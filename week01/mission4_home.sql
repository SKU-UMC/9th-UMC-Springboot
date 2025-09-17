/* 선택 지역에서 도전 완료한 미션 개수 칼럼 */
(select count(*) from location as l
left join store as s on s.location_id = l.location_id
left join mission as m on m.store_id = s.store_id
left join user_mission as um on um.mission_id = m.mission_id
left join user as u on u.user_id = um.user_id
where l.name = '안암동' and um.is_complete = 1 and u.user_id = 1)

/*
선택 지역에서 도전 가능한 미션 목록
u.user_id가 1번이라고 가정
- 필요 칼럼: 1. 지역이름, 2. 유저 보유 포인트 3. 가게 이름, 4. 미션 기한,
							5. 미션 조건, 6. 미션 포인트
							+ 7. 선택 지역에서 도전 완료한 미션 개수
*/

select l.name, u.point, s.name, m.deadline, m.conditional, m.point,
			(select count(*) from location as l
				left join store as s on s.location_id = l.location_id
				left join mission as m on m.store_id = s.store_id
				left join user_mission as um on um.mission_id = m.mission_id
				left join user as u on u.user_id = um.user_id
				where l.name = '안암동' and um.is_complete = 1 and u.user_id = 1) as complete_cnt
from location as l
left join store as s on s.location_id = l.location_id
left join mission as m on m.store_id = s.store_id
left join user_mission as um on um.mission_id = m.mission_id
left join user as u on u.user_id = um.user_id
where l.name = '안암동' and um.is_complete = 0 and u.user_id = 1
order by m.created_at desc
limit 10 offset 0;
