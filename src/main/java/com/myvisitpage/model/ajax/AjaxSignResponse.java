package com.myvisitpage.model.ajax;

import com.fasterxml.jackson.annotation.JsonView;
import com.myvisitpage.util.json.views.Views;

/**
 * Created by Павел on 20.04.2016.
 */
public class AjaxSignResponse {

    @JsonView(Views.Public.class)
    private String answer;

    @JsonView(Views.Public.class)
    private String text;

    public AjaxSignResponse() {
        this.answer = "404";
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
