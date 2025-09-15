-- HOME PAGE QUERIES

-- 선택 지역에서 사용자가 달성한(완료) 미션 개수
SELECT COUNT(*) AS completed_count
FROM user_mission um
    JOIN mission m ON m.id = um.mission_id
    JOIN store s ON s.id = m.store_id
WHERE um.user_id = :userId
  AND um.status = 'COMPLETED'
  AND s.address LIKE CONCAT(:regionPrefix, '%');

-- 도전 가능한 미션 목록 (한 번도 시도 안 한 미션만) - 페이징
SELECT
    m.id,
    s.name AS store_name,
    m.content AS mission_content,
    m.point,
    m.created_at
FROM mission m
    JOIN store s ON s.id = m.store_id
WHERE s.address LIKE CONCAT(:regionPrefix, '%')
  AND NOT EXISTS (
      SELECT 1 FROM user_mission um
               WHERE um.user_id = :userId
                 AND um.mission_id = m.id
  )
ORDER BY m.created_at DESC, m.id DESC
LIMIT :limit OFFSET :offset;

-- 도전 가능(미시도) 총 개수
SELECT COUNT(*)
FROM mission m
    JOIN store s ON s.id = m.store_id
WHERE s.address LIKE CONCAT(:regionPrefix, '%')
  AND NOT EXISTS (
      SELECT 1 FROM user_mission um
               WHERE um.user_id = :userId
                 AND um.mission_id = m.id
  );

-- 완료한 미션 목록 (페이징)
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
  AND um.status = 'COMPLETED'
  AND s.address LIKE CONCAT(:regionPrefix, '%')
ORDER BY um.updated_at DESC, um.id DESC
LIMIT :limit OFFSET :offset;

-- 완료한 미션 총 개수
SELECT COUNT(*)
FROM user_mission um
    JOIN mission m ON m.id = um.mission_id
    JOIN store s ON s.id = m.store_id
WHERE um.user_id = :userId
  AND um.status = 'COMPLETED'
  AND s.address LIKE CONCAT(:regionPrefix, '%');
