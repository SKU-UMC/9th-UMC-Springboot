--DDL

-- 유저
create table user (
                      id bigint primary key auto_increment,
                      name varchar(20) not null,
                      gender varchar(20) not null,
                      birth date not null,
                      address varchar(200),
                      created_at datetime not null,
                      updated_at datetime not null,
                      status varchar(20),
                      inactive_date datetime,
                      point int not null default 0
);

-- 가게
create table shop (
                      id bigint primary key auto_increment,
                      name varchar(20) not null,
                      address varchar(200),
                      owner varchar(20),
                      created_at datetime not null,
                      updated_at datetime not null,
                      region_id bigint not null,
                      foreign key (region_id) references region(id)
);

-- 지역
create table region (
                        id bigint primary key auto_increment,
                        name varchar(30) not null,
                        mission_reward_count int not null
);

-- 미션
create table mission (
                         id bigint primary key auto_increment,
                         title varchar(100) not null,
                         description varchar(200) not null,
                         created_at datetime not null,
                         updated_at datetime not null,
                         shop_id bigint not null,
                         foreign key (shop_id) references shop(id)
);

-- 유저미션
create table user_mission (
                              id bigint primary key auto_increment,
                              status varchar(20) not null,
                              success_requested_at datetime,
                              success_confirmed_at datetime,
                              is_review boolean,
                              bookmarked boolean,
                              created_at datetime not null,
                              updated_at datetime not null,
                              user_id bigint not null,
                              mission_id bigint not null,
                              foreign key (user_id) references user(id),
                              foreign key (mission_id) references mission(id)
);

-- 리뷰
create table review (
                        id bigint primary key auto_increment,
                        rating decimal(2,1),
                        content text,
                        created_at datetime not null,
                        updated_at datetime not null,
                        user_id bigint not null,
                        shop_id bigint not null,
                        foreign key (user_id) references user(id),
                        foreign key (shop_id) references shop(id)
);

-- 리뷰댓글
create table review_comment (
                                id bigint primary key auto_increment,
                                content text not null,
                                created_at datetime not null,
                                updated_at datetime not null,
                                review_id bigint not null,
                                user_id bigint not null,
                                foreign key (review_id) references review(id),
                                foreign key (user_id) references user(id)
);

-- 리뷰이미지
create table review_image (
                              id bigint primary key auto_increment,
                              image_url varchar(255) not null,
                              created_at datetime not null,
                              review_comment_id bigint not null,
                              foreign key (review_comment_id) references review_comment(id)
);

-- 유저지역
create table user_region (
                             user_id bigint not null,
                             region_id bigint not null,
                             primary key (user_id, region_id),
                             foreign key (user_id) references user(id),
                             foreign key (region_id) references region(id)
);

-- 유저음식취향
create table user_food (
                           user_id bigint not null,
                           food_type_id bigint not null,
                           primary key (user_id, food_type_id),
                           foreign key (user_id) references user(id),
                           foreign key (food_type_id) references food_type(id)
);

-- 음식 종류
create table food_type (
                           id bigint primary key auto_increment,
                           name varchar(30) not null
);

-- 유저약관
create table user_terms (
                            user_id bigint not null,
                            terms_id bigint not null,
                            agreed_at datetime not null,
                            primary key (user_id, terms_id),
                            foreign key (user_id) references user(id),
                            foreign key (terms_id) references terms(id)
);

-- 약관
create table terms (
                       id bigint primary key auto_increment,
                       title varchar(200) not null,
                       is_required boolean not null,
                       content text
);
