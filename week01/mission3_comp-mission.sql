/*
진행중, 진행완료 미션을 한번에 가져온다고 가정
u.user_id가 1번이라고 가정
- 필요 칼럼: 1. 미션 포인트, 2. 가게 이름, 3. 미션 조건, 4. 성공여부
*/
select m.point, s.name, m.conditional, um.is_complete from user_mission as um
left join mission as m on um.mission_id = m.mission = id
left join store as s on m.store_id = s.store_id
where um.user_id = 1
order by m.created_at desc
limit 10 offset 0;