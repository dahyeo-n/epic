-- =============================================
-- Database: epic
-- 테이블 생성 스크립트
-- =============================================

-- 기존 테이블 삭제 (역순으로 삭제 - 외래키 제약 조건 고려)
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post_tag;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS friend;
DROP TABLE IF EXISTS "user";

-- =============================================
-- 1. user 테이블
-- 사용자 정보를 저장하는 테이블
-- =============================================
CREATE TABLE "user" (
    user_no SERIAL NOT NULL,                                        -- 사용자 고유 번호. 자동 증가하는 기본키
    user_id VARCHAR(40) NOT NULL,                                   -- 사용자 고유 id. server에서 uuid로 자동 생성
    role VARCHAR(10) NOT NULL,                                      -- 사용자 역할 (예: 'USER', 'ADMIN')
    status VARCHAR(8) NOT NULL,                                     -- 사용자 계정 상태 (예: 'ACTIVE', 'INACTIVE', 'BLOCK')
    email VARCHAR(30) NOT NULL,                                     -- 사용자 이메일 주소. 중복 불가
    password VARCHAR(50) NOT NULL,                                  -- 암호화된 비밀번호
    nickname VARCHAR(20) NOT NULL,                                  -- 사용자 닉네임. 프로필에 표시되는 이름
    description VARCHAR(50),                                        -- 사용자 자기소개. 프로필에 표시되는 설명
    image_url VARCHAR(100),                                         -- 프로필 이미지 파일 경로 또는 url
    created_at TIMESTAMP NOT NULL,                                  -- 계정 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 계정 수정 일시
    
    CONSTRAINT pk_user PRIMARY KEY (user_no),
    CONSTRAINT uk_user_user_id UNIQUE (user_id),
    CONSTRAINT uk_user_email UNIQUE (email)
);

-- =============================================
-- 2. friend 테이블
-- 친구 관계를 저장하는 테이블
-- =============================================
CREATE TABLE friend (
    friend_no SERIAL NOT NULL,                                      -- 친구 고유 번호. 자동 증가하는 기본키
    my_user_id VARCHAR(40) NOT NULL,                                -- 본인의 고유 id. server에서 uuid로 자동 생성
    friend_user_id VARCHAR(40) NOT NULL,                            -- 친구의 고유 id. server에서 uuid로 자동 생성
    status VARCHAR(8) NOT NULL,                                     -- 친구와의 관계 (예: 'REQUEST', 'REQUESTED', 'FRIEND', 'BLOCK')
    created_at TIMESTAMP NOT NULL,                                  -- 친구 관계 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 친구 관계 수정 일시
    
    CONSTRAINT pk_friend PRIMARY KEY (friend_no),
    CONSTRAINT fk_friend_my_user_id FOREIGN KEY (my_user_id) REFERENCES "user"(user_id),
    CONSTRAINT fk_friend_friend_user_id FOREIGN KEY (friend_user_id) REFERENCES "user"(user_id)
);

-- =============================================
-- 3. category 테이블
-- 게시글 카테고리를 저장하는 테이블
-- =============================================
CREATE TABLE category (
    category_no SERIAL NOT NULL,                                    -- 카테고리 고유 번호. 자동 증가하는 기본키
    user_id VARCHAR(40) NOT NULL,                                   -- 사용자 고유 id
    category_name VARCHAR(20) NOT NULL,                             -- 카테고리명
    created_at TIMESTAMP NOT NULL,                                  -- 카테고리 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 카테고리 수정 일시
    
    CONSTRAINT pk_category PRIMARY KEY (category_no),
    CONSTRAINT fk_category_user_id FOREIGN KEY (user_id) REFERENCES "user"(user_id)
);

-- =============================================
-- 4. post 테이블
-- 게시글을 저장하는 테이블
-- =============================================
CREATE TABLE post (
    post_no SERIAL NOT NULL,                                        -- 게시글 고유 번호. 자동 증가하는 기본키
    user_id VARCHAR(40) NOT NULL,                                   -- 사용자 고유 id
    category_no INTEGER NOT NULL,                                   -- 카테고리 고유 번호
    status VARCHAR(8) NOT NULL,                                     -- 게시글 활성화 상태 (예: 'ACTIVE', 'TEMPORARY', 'INACTIVE')
    title VARCHAR(50) NOT NULL,                                     -- 게시글 제목
    content VARCHAR(1000) NOT NULL,                                 -- 게시글 내용
    created_at TIMESTAMP NOT NULL,                                  -- 게시글 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 게시글 수정 일시
    
    CONSTRAINT pk_post PRIMARY KEY (post_no),
    CONSTRAINT fk_post_user_id FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    CONSTRAINT fk_post_category_no FOREIGN KEY (category_no) REFERENCES category(category_no) -- TODO erd 누락된 것 적용
);

-- =============================================
-- 5. post_tag 테이블
-- 게시글 태그를 저장하는 테이블
-- =============================================
CREATE TABLE post_tag (
    post_tag_no SERIAL NOT NULL,                                    -- 게시글 태그 고유 번호. 자동 증가하는 기본키
    post_no INTEGER NOT NULL,                                       -- 게시글 고유 번호
    tag_name VARCHAR(10) NOT NULL,                                  -- 태그명
    created_at TIMESTAMP NOT NULL,                                  -- 태그 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 태그 수정 일시
    
    CONSTRAINT pk_post_tag PRIMARY KEY (post_tag_no),
    CONSTRAINT fk_post_tag_post_no FOREIGN KEY (post_no) REFERENCES post(post_no) -- TODO erd 누락된 것 적용
);

-- =============================================
-- 6. comment 테이블
-- 댓글을 저장하는 테이블
-- =============================================
CREATE TABLE comment (
    comment_no SERIAL NOT NULL,                                     -- 댓글 고유 번호. 자동 증가하는 기본키
    user_id VARCHAR(40) NOT NULL,                                   -- 사용자 고유 id
    post_no INTEGER NOT NULL,                                       -- 게시글 고유 번호
    parent_comment_no INTEGER,                                      -- 상위 댓글 고유 번호 (대댓글인 경우)
    content VARCHAR(1000) NOT NULL,                                 -- 댓글 내용
    created_at TIMESTAMP NOT NULL,                                  -- 댓글 생성 일시
    updated_at TIMESTAMP NOT NULL,                                  -- 댓글 수정 일시
    
    CONSTRAINT pk_comment PRIMARY KEY (comment_no),
    CONSTRAINT fk_comment_user_id FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    CONSTRAINT fk_comment_post_no FOREIGN KEY (post_no) REFERENCES post(post_no),
    CONSTRAINT fk_comment_parent_comment_no FOREIGN KEY (parent_comment_no) REFERENCES comment(comment_no)
);

-- =============================================
-- 인덱스 생성 (성능 최적화)
-- =============================================
CREATE INDEX idx_friend_my_user_id ON friend(my_user_id);
CREATE INDEX idx_friend_friend_user_id ON friend(friend_user_id);
CREATE INDEX idx_category_user_id ON category(user_id);
CREATE INDEX idx_post_user_id ON post(user_id);
CREATE INDEX idx_post_category_no ON post(category_no);
CREATE INDEX idx_post_tag_post_no ON post_tag(post_no);
CREATE INDEX idx_comment_user_id ON comment(user_id);
CREATE INDEX idx_comment_post_no ON comment(post_no);
CREATE INDEX idx_comment_parent_comment_no ON comment(parent_comment_no);
