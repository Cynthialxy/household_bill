package chrkey.bean;

public class Bill {
    String time;
    String in_or_out;
    String type;
    String account;
    int sum;
    String person;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    String remarks;
    String name;


    public String getIn_or_out() {
        return in_or_out;
    }

    public void setIn_or_out(String in_or_out) {
        this.in_or_out = in_or_out;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(String sum) {
        this.sum = Integer.parseInt(sum);
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
