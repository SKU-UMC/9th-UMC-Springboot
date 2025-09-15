-- MISSION PAGE QUERIES

-- 완료만 제외하고 미션 목록 조회
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
                 AND um.status = 'COMPLETED'
  )
ORDER BY m.created_at DESC, m.id DESC
LIMIT :limit OFFSET :offset;

-- 완료 제외 목록 총 개수
SELECT COUNT(*)
FROM mission m
    JOIN store s ON s.id = m.store_id
WHERE s.address LIKE CONCAT(:regionPrefix, '%')
  AND NOT EXISTS (
      SELECT 1 FROM user_mission um
               WHERE um.user_id = :userId
                 AND um.mission_id = m.id
                 AND um.status = 'COMPLETED'
  );