-- DML/SELECT

-- 리뷰 작성하는 쿼리
insert into review (rating, content, created_at, updated_at, user_id, shop_id)
values (5, '음 너무 맛있어요', now(), now(), 1, 1);
-- now()는 현재 시간을 넣는 MySQL 함수


-- 마이페이지 화면 쿼리
select u.id,
       u.name  as nickname,
       u.email,
       u.phone,
       u.point
from user u
where u.id = 1;


-- 내가 진행중, 진행 완료한 미션 모아서 보는 쿼리
select um.id          as user_mission_id,
       m.title        as mission_title,
       m.description  as mission_desc,
       s.name         as shop_name,
       um.status,
       um.created_at
from user_mission um
         join mission m on um.mission_id = m.id
         join shop s on m.shop_id = s.id
-- 미션은 가게의 포함관계
where um.user_id = 1
  and um.status in ('IN_PROGRESS', 'COMPLETED')
  and um.id > 20                  -- 마지막으로 본 user_mission.id
order by um.id asc
    limit 10;


-- 홈 화면 쿼리
select m.id          as mission_id,
       m.title       as mission_title,
       m.description as mission_description,
       s.name        as shop_name,
       r.name        as region_name,
       m.created_at
from mission m
         join shop s on m.shop_id = s.id
         join region r on s.region_id = r.id


-- 가게는 지역의 포함관계
where r.id = 1
  and m.id > 50               -- 마지막으로 본 mission.id
order by m.id asc
        limit 10;
