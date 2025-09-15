-- REVIEW / REPLY QUERIES

-- 특정 미션의 리뷰 목록 (페이징)
SELECT
    r.id,
    u.nickname,
    r.rating,
    r.content,
    r.created_at
FROM review r
    JOIN `user` u ON u.id = r.user_id
WHERE r.mission_id = :missionId
ORDER BY r.created_at DESC, r.id DESC
LIMIT :limit OFFSET :offset;

-- 특정 미션의 리뷰 총 개수
SELECT COUNT(*)
FROM review
WHERE mission_id = :missionId;

-- 내 리뷰 목록 (페이징)
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

-- 내 리뷰 총 개수
SELECT COUNT(*)
FROM review
WHERE user_id = :userId;

-- 리뷰 등록
INSERT INTO review (user_id, mission_id, rating, content)
VALUES (:userId, :missionId, :rating, :content);

-- 리뷰 수정
UPDATE review
SET content = :content,
    rating = :rating
WHERE id = :reviewId;

-- 리뷰 삭제
DELETE FROM review
WHERE id = :reviewId;

-- 답글 목록 (리뷰별)
SELECT
    rp.id,
    rp.review_id,
    rp.content,
    rp.created_at
FROM reply rp
WHERE rp.review_id = :reviewId
ORDER BY rp.created_at DESC, rp.id DESC
    LIMIT :limit OFFSET :offset;

-- 답글 등록
INSERT INTO reply (review_id, content)
VALUES (:reviewId, :content);
