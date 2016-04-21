package com.myvisitpage.controller;

import com.myvisitpage.model.CustomerMessage;
import com.myvisitpage.model.Project;
import com.myvisitpage.model.ProjectChunk;
import com.myvisitpage.model.User;
import com.myvisitpage.model.ajax.AjaxSignResponse;
import com.myvisitpage.service.CustomerMessageService;
import com.myvisitpage.service.ProjectService;
import com.myvisitpage.service.RoleService;
import com.myvisitpage.service.UserService;
import com.myvisitpage.util.exceptions.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.function.Function;

/**
 * Created by Павел on 01.04.2016.
 */

@Controller
@RequestMapping("/")
public class MainSiteController {

    @Autowired
    private CustomerMessageService messageService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserService userService;


    private Function<Model, String> customerGet = this::customerPageGet;

    @FunctionalInterface
    interface Function2<T1, T2, R> {
        R apply(T1 t1, T2 t2);
    }

    /*
    * Index page logic
    * */
    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public String index(Model model) {

        model.addAttribute("name", getLoggedUsername());
        return "hello";
    }

    @ResponseBody
    @RequestMapping(value = "/hello/is_valid", method = RequestMethod.GET)
    public AjaxSignResponse checkEmail(@RequestParam String email) {
        AjaxSignResponse response = new AjaxSignResponse();
        if (userService.getByEmail(email) != null) {
            response.setAnsw("201");
        }
        else {
            response.setAnsw("200");
        }
        return response;
    }

    @RequestMapping(value = "/credits")
    public ModelAndView credits() {
        return new ModelAndView("credits");
    }


    /*
    * login and sign-up page
    * */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(String message) {
        return new ModelAndView("login-form", "sign_message", message);
    }

    @RequestMapping(value = "/sign-up", method = RequestMethod.GET)
    public String signUpView(Model model) {
        model.addAttribute("newUser", new User());
        return "signUp";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView signUp(@ModelAttribute("newUser") User user, Model model) {
        user.setRole(roleService.getById(2));
        userService.save(user);
        return login("You successfully sign-up! Login now.");
    }


    /*
    * Customers page methods
    * */

    @RequestMapping(value = "/customers", method = RequestMethod.GET)
    public String customerPageGet(Model model) {
        model.addAttribute("messages", messageService.getAllByEmail(getLoggedUsername()));
        model.addAttribute("projects", projectService.getAll(getLoggedUsername()));
        model.addAttribute("customerMessage", new CustomerMessage(LocalDateTime.now()));
        model.addAttribute("newProject", new Project());
        model.addAttribute("message_button_text", "Send message");
        return "customers";
    }

    @RequestMapping(value = "/add-project", method = RequestMethod.POST)
    public String addProject(@ModelAttribute("newProject") Project project, Model model) {
        project.setUserEmail(getLoggedUsername());
        projectService.save(project);
        return customerPageGet(model);
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/project_delete", method = RequestMethod.GET)
    public String deleteProject(@RequestParam(value = "id", required = true) int id, Model model) {
        Function2<Integer, String, Void> func = (a,b) -> projectService.delete(a,b);
        return excCheck(func,id, customerGet, model);
    }

    @RequestMapping(value = "/add-message", method = RequestMethod.POST)
    public String sendMessage(@ModelAttribute("customerMessage") CustomerMessage message, Model model) {
        message.setUserEmail(getLoggedUsername());
        messageService.save(message);
        return customerPageGet(model);
    }

    @RequestMapping(value = "/message_update", method = RequestMethod.GET)
    public String updateMessage(@RequestParam(value = "id", required = true) int id, Model model) {
       try {
            model.addAttribute("customerMessage", messageService.get(id, getLoggedUsername()));
        }
        catch (NotFoundException e) {
            return "notFound";
        }
        model.addAttribute("messages", messageService.getAllByEmail(getLoggedUsername()));
        model.addAttribute("projects", projectService.getAll(getLoggedUsername()));
        model.addAttribute("newProject", new Project());
        model.addAttribute("message_button_text", "Update message");
        return "customers";
    }


    @RequestMapping(value = "/message_delete", method = RequestMethod.GET)
    public String deleteMessage(@RequestParam(value = "id", required = true) int id, Model model) {
        Function2<Integer, String, Void> func = (a, b) -> messageService.delete(a, b);
        return excCheck(func, id, customerGet, model);
    }
    /*
    * Project page methods
    * */

    @RequestMapping(value = "/project", method = RequestMethod.GET)
    public String getProject(@RequestParam(value = "id", required = true) int id, Model model) {

        try {
            model.addAttribute("chunks", projectService.getChunks(id, getLoggedUsername()));
        } catch (NotFoundException e) {
            return "notFound";
        }
        model.addAttribute("newChunk", new ProjectChunk());
        return "project";
    }

    /*
    * Util methods
    * */
    public String getLoggedUsername() {
        Object o = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (o instanceof UserDetails) {
            UserDetails ud = (UserDetails) o;
            return ud.getUsername();
        } else if (o instanceof String) {
            return (String) o;
        }
        return null;
    }

    private String excCheck(Function2 func, Integer id, Function get, Model model) {
        try {
            func.apply(id, getLoggedUsername());
            return (String) get.apply(model);
        } catch (NotFoundException e) {
            return "notFound";
        }
    }
}
