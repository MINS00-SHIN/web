package com.team2.healthsns.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommunityVO {
    private int post_id;
    private String userid;
    private String title;
    private String content;
    private String cat;
    private int like;
    private int views;
    private String write_date;
    private String board_cat; 
}
