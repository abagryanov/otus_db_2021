package ru.otus.cassandra.model;

import java.util.UUID;

public interface User {
    UUID getId();
    void setId(UUID id);
    String getFirstName();
    void setFirstName(String firstName);
    String getLastName();
    void setLastName(String lastName);
    String getCity();
    void setCity(String city);
}
