package com.lm.model;

import java.io.Serializable;

public class IdRequest<T extends Serializable> extends Request {
    private T id;

    public T getId() {
        return id;
    }

    public void setId(T id) {
        this.id = id;
    }
}
