create table user_info
(
    userid   varchar(45)                        not null
        primary key,
    userpwd  varchar(45)                        not null,
    username varchar(45)                        not null,
    email    varchar(45)                        not null,
    pwd_q    varchar(45)                        not null,
    pwd_a    varchar(45)                        not null,
    date     datetime default CURRENT_TIMESTAMP not null,
    comment  varchar(255)                       null
);

create table board
(
    post_id    int auto_increment
        primary key,
    userid     varchar(45)                        not null,
    title      varchar(100)                       not null,
    content    longtext                           not null,
    cat        varchar(45)                        null,
    `like`     int      default 0                 not null,
    views      int      default 0                 not null,
    write_date datetime default CURRENT_TIMESTAMP not null,
    board_cat  varchar(45)                        not null,
    bodypart   longtext                           null,
    constraint fk_board_USER_INFO
        foreign key (userid) references user_info (userid)
);

create index fk_board_USER_INFO_idx
    on board (userid);

create table comment
(
    comment_id     int auto_increment
        primary key,
    userid         varchar(45)                        not null,
    target_post_id int                                not null,
    content        longtext                           null,
    `like`         int      default 0                 not null,
    target_parent  int                                null,
    write_date     datetime default CURRENT_TIMESTAMP not null,
    depth          tinyint                            not null,
    isdelete       int      default 0                 not null,
    constraint fk_comment_USER_INFO1
        foreign key (userid) references user_info (userid),
    constraint fk_comment_board1
        foreign key (target_post_id) references board (post_id)
            on delete cascade
);

create index fk_comment_USER_INFO1_idx
    on comment (userid);

create index fk_comment_board1_idx
    on comment (target_post_id);

create table follow
(
    userid      varchar(45) not null,
    follower_id varchar(45) not null,
    constraint fk_follow_USER_INFO1
        foreign key (userid) references user_info (userid),
    constraint fk_follow_USER_INFO2
        foreign key (follower_id) references user_info (userid)
);

create index fk_follow_USER_INFO1_idx
    on follow (userid);

create index fk_follow_USER_INFO2_idx
    on follow (follower_id);

create table guest_book
(
    target_home varchar(45)                        not null,
    userid      varchar(45)                        not null,
    write_date  datetime default CURRENT_TIMESTAMP not null,
    content     longtext                           not null,
    guestbookID int auto_increment
        primary key,
    constraint fk_guest_book_USER_INFO1
        foreign key (userid) references user_info (userid),
    constraint fk_guest_book_USER_INFO2
        foreign key (target_home) references user_info (userid)
);

create index fk_guest_book_USER_INFO1_idx
    on guest_book (userid);

create index fk_guest_book_USER_INFO2_idx
    on guest_book (target_home);

create table memo
(
    memoid     int auto_increment
        primary key,
    userid     varchar(45)                          not null,
    emoji      int                                  not null,
    write_date datetime   default CURRENT_TIMESTAMP not null,
    cat        varchar(10)                          not null,
    content    longtext                             not null,
    bodypart   longtext                             not null,
    ADD_AUTH   tinyint(1) default 0                 not null,
    constraint fk_memo_USER_INFO1
        foreign key (userid) references user_info (userid)
);

create index fk_memo_USER_INFO1_idx
    on memo (userid);

create table review
(
    reviewid  int auto_increment
        primary key,
    userid    varchar(45)  not null,
    name      varchar(200) not null,
    rating    int          not null,
    Latitude  varchar(100) not null,
    longitude varchar(100) not null,
    review    varchar(500) not null,
    constraint fk_review_USER_INFO1
        foreign key (userid) references user_info (userid)
);

create index fk_review_USER_INFO1_idx
    on review (userid);

create table visit_count
(
    owner_id     varchar(45)              not null,
    visitor_id   varchar(45)              not null,
    visited_date date default (curdate()) null,
    constraint idx_unique_visit
        unique (owner_id, visitor_id, visited_date),
    constraint fk_visit_count_USER_INFO1
        foreign key (owner_id) references user_info (userid),
    constraint fk_visit_count_USER_INFO2
        foreign key (visitor_id) references user_info (userid)
);

create index fk_visit_count_USER_INFO1_idx
    on visit_count (owner_id);

create index fk_visit_count_USER_INFO2_idx
    on visit_count (visitor_id);


