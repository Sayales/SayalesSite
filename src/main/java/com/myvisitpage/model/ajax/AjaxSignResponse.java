package com.myvisitpage.model.ajax;

import com.fasterxml.jackson.annotation.JsonView;
import com.myvisitpage.util.json.views.Views;

/**
 * Created by Павел on 20.04.2016.
 */
public class AjaxSignResponse {

    @JsonView(Views.Public.class)
    private String answ;

    public AjaxSignResponse() {
        this.answ = "404";
    }

    public String getAnsw() {
        return answ;
    }

    public void setAnsw(String answ) {
        this.answ = answ;
    }
}
