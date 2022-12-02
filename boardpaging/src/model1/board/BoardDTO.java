package model1.board;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BoardDTO {
	private String num;
	private String title;
	private String content;
	private String id;
	private java.sql.Date postdate;
	private String visitcount;
	private String name;
}
