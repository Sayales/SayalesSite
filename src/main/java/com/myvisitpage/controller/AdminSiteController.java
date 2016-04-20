package com.myvisitpage.controller;

import com.myvisitpage.model.*;
import com.myvisitpage.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by Павел on 10.04.2016.
 */
@Controller
@RequestMapping("/admin*")
public class AdminSiteController {
    @Autowired
    private CustomerMessageService messageService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserService userService;
    @Autowired
    private ChunkService chunkService;
    /*
   * User list logic
   * */
    @RequestMapping(value = "/admin_userlist", method = RequestMethod.GET)
    public String getUsers(Model model) {
        model.addAttribute("users", userService.getAll());
        model.addAttribute("newUser", new User());
        Map<String,String> roleList = new LinkedHashMap<>();
        roleList.put(roleService.getById(1).getRoleText(), "Admin");
        roleList.put(roleService.getById(2).getRoleText(), "User");
        model.addAttribute("roleList",roleList);
        return "users";
    }

    @RequestMapping(value = "/admin_user_delete", method = RequestMethod.GET)
    public String deleteUser(@RequestParam(value = "id", required = true) int id, Model model) {
        userService.delete(id);
        return getUsers(model);
    }

    @RequestMapping(value = "/admin_add_user", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("newUser") @Valid  User user, BindingResult result, Model model) {
        userService.save(user);
        return getUsers(model);
    }

    @RequestMapping(value = "/admin_user_update", method = RequestMethod.GET)
    public String updateUser(@RequestParam(value = "id", required = true) int id, Model model) {
        model.addAttribute("users", userService.getAll());
        Map<String,String> roleList = new LinkedHashMap<>();
        roleList.put("admin", "Admin");
        roleList.put("user", "User");
        model.addAttribute("roleList",roleList);
        model.addAttribute("newUser", userService.getById(id));
        return "users";
    }

    /*
    * Admin`s side of customers
    * */
    @RequestMapping(value = "/admin_customers", method = RequestMethod.GET)
    public String customersAdminGet(@RequestParam(value = "id", required = true) int id, Model model) {
        String userEmail = userService.getById(id).getEmail();
        model.addAttribute("messages", messageService.getAllByEmail(userEmail));
        model.addAttribute("projects", projectService.getAll(userEmail));
        model.addAttribute("customerMessage", new CustomerMessage(userEmail));
        model.addAttribute("newProject", new Project());
        model.addAttribute("message_button_text", "Send message");
        model.addAttribute("admin_label", "admin_");
        return "customers";
    }

    @RequestMapping(value = "/admin_add-message", method = RequestMethod.POST)
    public String sendAdmMessage(@ModelAttribute("customerMessage") CustomerMessage message, Model model) {
        messageService.save(message);
        return customersAdminGet(userService.getByEmail(message.getUserEmail()).getId(), model);
    }

    @RequestMapping(value = "/admin_message_update", method = RequestMethod.GET)
    public String adminMessageUpdate(@RequestParam(value = "id", required = true) int messId, Model model) {
        CustomerMessage message = messageService.getById(messId);
        model.addAttribute("messages", messageService.getAllByEmail(message.getUserEmail()));
        model.addAttribute("projects", projectService.getAll(message.getUserEmail()));
        model.addAttribute("customerMessage", message);
        model.addAttribute("newProject", new Project());
        model.addAttribute("message_button_text", "Update message");
        model.addAttribute("admin_label", "admin_");
        return "customers";
    }

    @RequestMapping(value = "/admin_message_delete", method = RequestMethod.GET)
    public String adminMessageDelete(@RequestParam(value = "id", required = true) int id, Model model) {
        User u = userService.getByEmail(messageService.getById(id).getUserEmail());
        messageService.deleteById(id);
        return customersAdminGet(u.getId(),model);
    }
    /*
    * Project chunks
    * */
    @RequestMapping(value = "/admin_chunk_delete", method = RequestMethod.GET)
    public ModelAndView chunkDelete(@RequestParam(value = "id", required = true) int id) {
        ProjectChunk ch = chunkService.get(id);
        chunkService.delete(id);
        return new ModelAndView("project", "chunks", projectService.getChunks(ch.getProject().getId()));
    }
}
