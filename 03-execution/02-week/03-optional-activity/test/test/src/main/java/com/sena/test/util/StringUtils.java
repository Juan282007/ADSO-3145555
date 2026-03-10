package com.sena.test.util;

public class StringUtils {

    public static boolean isEmpty(String text) { 
        return text == null || text.trim().isEmpty(); // Verifica si el texto es nulo o está vacío después de eliminar espacios en blanco
    }
}