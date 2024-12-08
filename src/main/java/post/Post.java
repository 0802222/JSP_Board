package post;

public class Post {
    private int no;
    private String writer;
    private String title;
    private String content;
    private String register;

    // 기본 생성자
    public Post() {
    }

    // 매개변수 생성자
    public Post(int no, String writer, String title, String content, String register) {
        this.no = no;
        this.writer = writer;
        this.title = title;
        this.content = content;
        this.register = register;
    }

    // Getter
    public int getNo() {
        return this.no;
    }

    public String getWriter() {
        return this.writer;
    }

    public String getTitle() {
        return this.title;
    }

    public String getContent() {
        return this.content;
    }

    public String getRegister() {
        return this.register;
    }

    // Setter
    public void setNo(int no) {
        this.no = no;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty");
        }
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    // toString() 메서드
    @Override
    public String toString() {
        return "Post{" +
                "no=" + no +
                ", writer='" + writer + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", register='" + register + '\'' +
                '}';
    }
}