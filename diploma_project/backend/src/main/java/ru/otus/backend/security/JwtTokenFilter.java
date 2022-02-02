package ru.otus.backend.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.ExpiredJwtException;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UserDetailsRepositoryReactiveAuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.filter.GenericFilterBean;
import ru.otus.backend.dto.ErrorResponseDto;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@AllArgsConstructor
public class JwtTokenFilter extends GenericFilterBean {
    private JwtTokenProvider jwtTokenProvider;
    private ObjectMapper objectMapper;
    private String restApiBasePath;

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        try {
            HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
            String path = httpServletRequest.getServletPath();
            if (path.contains(restApiBasePath)) {
                Optional<String> tokenOpt = jwtTokenProvider.resolveToken(httpServletRequest);
                if (tokenOpt.isPresent()) {
                    Authentication authentication = jwtTokenProvider.getAuthentication(tokenOpt.get());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            }
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (ExpiredJwtException e) {
            HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
            httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            sendError(httpServletResponse, "Expired token");
        } catch (Exception e) {
            e.printStackTrace();
            HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
            httpServletResponse.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            sendError(httpServletResponse, "Invalid token");
        }
    }

    private void sendError(HttpServletResponse httpServletResponse, String errorMsg) throws IOException {
        httpServletResponse.setContentType(MimeTypeUtils.APPLICATION_JSON_VALUE);
        httpServletResponse.addHeader("Access-Control-Allow-Origin", "*");
        ErrorResponseDto errorResponseDto = new ErrorResponseDto(errorMsg);
        httpServletResponse.getWriter().write(objectMapper.writeValueAsString(errorResponseDto));
        httpServletResponse.getWriter().flush();
        httpServletResponse.getWriter().close();
    }
}
