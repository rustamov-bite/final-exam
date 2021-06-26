package com.example.demo.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.RestController;

import static java.util.stream.Collectors.toList;

@ControllerAdvice(annotations = RestController.class)
public class ExceptionHandler {
    @org.springframework.web.bind.annotation.ExceptionHandler(BindException.class)
    protected ResponseEntity<Object> handleBindException(BindException ex) {
        var bindingResult = ex.getBindingResult();

        var apiFieldErrors = bindingResult
                .getFieldErrors()
                .stream()
                .map(fe -> String.format("%s -> %s", fe.getField(), fe.getDefaultMessage()))
                .collect(toList());
        return ResponseEntity.unprocessableEntity()
                .body(apiFieldErrors);
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(IllegalArgumentException.class)
    protected ResponseEntity<Object> handleIllegalArgumentException(IllegalArgumentException ex) {
        var illegalResult = ex.getMessage();

        return ResponseEntity.unprocessableEntity()
                .body(illegalResult);
    }
    @org.springframework.web.bind.annotation.ExceptionHandler(ResourceNotFoundException.class)
    protected ResponseEntity<Object> handleResourceNotFoundException(ResourceNotFoundException notFoundException) {
        var notFound = "Not found:" + notFoundException.getResource() + " By Id:" + notFoundException.getId();

        return ResponseEntity.unprocessableEntity()
                .body(notFound);
    }
}
