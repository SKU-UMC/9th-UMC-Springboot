-- MY PAGE QUERIES

-- 내 프로필
SELECT
    u.id, u.nickname, u.email, u.phone, u.point,
    u.created_at, u.updated_at
FROM `user` u
WHERE u.id = :userId;

-- 내가 쓴 리뷰 목록 (페이징)
SELECT
    r.id,
    r.mission_id,
    r.rating,
    r.content,
    r.created_at
FROM review r
WHERE r.user_id = :userId
ORDER BY r.created_at DESC, r.id DESC
LIMIT :limit OFFSET :offset;

-- 내가 쓴 리뷰 총 개수
SELECT COUNT(*)
FROM review
WHERE user_id = :userId;

-- 1:1 문의 목록 (페이징)
SELECT
    i.id,
    i.content,
    i.created_at
FROM inquiry i
WHERE i.user_id = :userId
ORDER BY i.created_at DESC, i.id DESC
LIMIT :limit OFFSET :offset;

-- 1:1 문의 총 개수
SELECT COUNT(*)
FROM inquiry
WHERE user_id = :userId;

-- 완료한 미션 히스토리 (페이징)
SELECT
    m.id,
    s.name AS store_name,
    m.content AS mission_content,
    m.point,
    um.updated_at AS completed_at
FROM user_mission um
    JOIN mission m ON m.id = um.mission_id
    JOIN store s ON s.id = m.store_id
WHERE um.user_id = :userId
  AND um.status  = 'COMPLETED'
ORDER BY um.updated_at DESC, um.id DESC
LIMIT :limit OFFSET :offset;

-- 완료한 미션 총 개수
SELECT COUNT(*)
FROM user_mission
WHERE user_id = :userId
  AND status  = 'COMPLETED';
