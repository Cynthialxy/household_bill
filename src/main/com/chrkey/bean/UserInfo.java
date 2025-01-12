package chrkey.bean;

public class UserInfo {
    String id;
    String name;
    String password;
    String is_admin_or_not;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIs_admin_or_not() {
        return is_admin_or_not;
    }

    public void setIs_admin_or_not(String is_admin_or_not) {
        this.is_admin_or_not = is_admin_or_not;
    }
}
