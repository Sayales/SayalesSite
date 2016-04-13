package com.myvisitpage.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * Created by Павел on 05.04.2016.
 */

@Entity
@Table(name = "roles")
public class Role implements Serializable {

    @Id
    @GeneratedValue
    private int id;

    @Column(name = "role")
    private String roleText;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "user_roles",
        joinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id")},
        inverseJoinColumns = {@JoinColumn(name="user_id", referencedColumnName="id")})
    private Set<User> userRoles;

    public Role() {
    }

    public Role(String role, Set<User> userRoles) {
        this.roleText = role;
        this.userRoles = userRoles;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoleText() {
        return roleText;
    }

    public void setRoleText(String role) {
        this.roleText = role;
    }

    public Set<User> getUserRoles() {
        return userRoles;
    }

    public void setUserRoles(Set<User> userRoles) {
        this.userRoles = userRoles;
    }

    @Override
    public String toString() {
        return "Role{" +
                "role='" + roleText + '\'' +
                '}';
    }
}
