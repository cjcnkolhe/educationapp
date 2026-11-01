package com.vedit.educationapp.model;

public class Student {

    private Long id;
    private String name;
    private String email;
    private String phone;
    private String course;

    // Default constructor
    public Student() {
    }

    // Parameterized constructor
    public Student(Long id, String name, String email,
                   String phone, String course) {

        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.course = course;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }
}