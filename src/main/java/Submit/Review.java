package Submit;

import java.sql.Timestamp;

public class Review {
    private int id;
    private String userName;
    private String content;
    private Timestamp createdAt; // Timestamp field

    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt; // Getter for createdAt
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt; // Setter for createdAt
    }
}
