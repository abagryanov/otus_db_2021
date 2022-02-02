package ru.otus.backend.utils;

import java.math.BigDecimal;

public class CommonUtils {
    public static double parseDouble(BigDecimal value) {
        return value == null ? 0.0 : value.doubleValue();
    }
}
