/*
s.store_id가 1번이라고 가정
*/
select r.*, u.name from review as r
left join store as s on r.store_id = s.store_id
left join user as u on r.user_id = u.user_id
where s.store_id = 1;