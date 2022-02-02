package ru.otus.backend.utils;

import java.util.Set;

public class CustomerUtils {
    public static Set<String> getDefaultCustomerRoles() {
        return Set.of("USER");
    }
}
