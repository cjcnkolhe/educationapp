package com.vedit.educationapp.controller;

import com.vedit.educationapp.model.Student;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@Controller
public class StudentController {

    private final List<Student> students = new ArrayList<>();

    private final AtomicLong idGenerator = new AtomicLong(1);

    // Sample records
    public StudentController() {

        students.add(new Student(
                idGenerator.getAndIncrement(),
                "Rahul",
                "rahul@gmail.com",
                "9876543210",
                "Java Full Stack"
        ));

        students.add(new Student(
                idGenerator.getAndIncrement(),
                "Amit",
                "amit@gmail.com",
                "9876501234",
                "AWS DevOps"
        ));
    }

    // Dashboard
    @GetMapping("/")
    public String dashboard(Model model) {

        model.addAttribute("studentCount", students.size());

        return "dashboard";
    }

    // Display all students
    @GetMapping("/students")
    public String list(Model model) {

        model.addAttribute("students", students);

        return "students";
    }

    // Add Student Form
    @GetMapping("/students/new")
    public String createForm(Model model) {

        model.addAttribute("student", new Student());
        model.addAttribute("pageTitle", "Add Student");

        return "student-form";
    }

    // Save Student
    @PostMapping("/students")
    public String save(@ModelAttribute Student student,
                       RedirectAttributes redirect) {

        student.setId(idGenerator.getAndIncrement());

        students.add(student);

        redirect.addFlashAttribute(
                "success", "Student saved successfully."
        );

        return "redirect:/students";
    }

    // Edit Student Form
    @GetMapping("/students/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {

        Student student = students.stream()
                .filter(s -> s.getId().equals(id))
                .findFirst()
                .orElseThrow();

        model.addAttribute("student", student);
        model.addAttribute("pageTitle", "Edit Student");

        return "student-form";
    }

    // Update Student
    @PostMapping("/students/update/{id}")
    public String update(@PathVariable Long id,
                         @ModelAttribute Student updatedStudent,
                         RedirectAttributes redirect) {

        Student existingStudent = students.stream()
                .filter(s -> s.getId().equals(id))
                .findFirst()
                .orElseThrow();

        existingStudent.setName(updatedStudent.getName());
        existingStudent.setEmail(updatedStudent.getEmail());
        existingStudent.setPhone(updatedStudent.getPhone());
        existingStudent.setCourse(updatedStudent.getCourse());

        redirect.addFlashAttribute(
                "success", "Student updated successfully."
        );

        return "redirect:/students";
    }

    // Delete Student
    @PostMapping("/students/delete/{id}")
    public String delete(@PathVariable Long id,
                         RedirectAttributes redirect) {

        students.removeIf(s -> s.getId().equals(id));

        redirect.addFlashAttribute(
                "success", "Student deleted successfully."
        );

        return "redirect:/students";
    }
}