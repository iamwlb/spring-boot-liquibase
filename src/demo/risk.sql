/*
 Navicat Premium Data Transfer

 Source Server         : 68
 Source Server Type    : PostgreSQL
 Source Server Version : 100015
 Source Host           : 10.250.125.68:5432
 Source Catalog        : risk_discovery
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 100015
 File Encoding         : 65001

 Date: 27/10/2021 11:11:39
*/


-- ----------------------------
-- Table structure for basic_cve_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."basic_cve_info";
CREATE TABLE "public"."basic_cve_info" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "cve_id" varchar(64) COLLATE "pg_catalog"."default",
  "cwe_id" varchar(64) COLLATE "pg_catalog"."default",
  "score" varchar(32) COLLATE "pg_catalog"."default",
  "title" varchar(512) COLLATE "pg_catalog"."default",
  "type" varchar(256) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "official_solutions" text COLLATE "pg_catalog"."default",
  "suggestions" text COLLATE "pg_catalog"."default",
  "references_list" text COLLATE "pg_catalog"."default",
  "cnvd_id" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "severity" varchar(64) COLLATE "pg_catalog"."default",
  "vector_string" varchar(255) COLLATE "pg_catalog"."default",
  "exp_flag" varchar(32) COLLATE "pg_catalog"."default",
  "attack_complexity" varchar(255) COLLATE "pg_catalog"."default",
  "attack_vector" varchar(255) COLLATE "pg_catalog"."default",
  "availability_impact" varchar(255) COLLATE "pg_catalog"."default",
  "confidentiality_impact" varchar(255) COLLATE "pg_catalog"."default",
  "integrity_impact" varchar(255) COLLATE "pg_catalog"."default",
  "privileges_required" varchar(255) COLLATE "pg_catalog"."default",
  "user_interaction" varchar(255) COLLATE "pg_catalog"."default",
  "risk_type" varchar(255) COLLATE "pg_catalog"."default",
  "public_time" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" varchar(255) COLLATE "pg_catalog"."default",
  "cnnvd_number" varchar(64) COLLATE "pg_catalog"."default",
  "affects" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."basic_cve_info"."cve_id" IS 'cveId';
COMMENT ON COLUMN "public"."basic_cve_info"."cwe_id" IS '暂时没有用到，也存下来';
COMMENT ON COLUMN "public"."basic_cve_info"."score" IS '评分';
COMMENT ON COLUMN "public"."basic_cve_info"."title" IS '漏洞名称';
COMMENT ON COLUMN "public"."basic_cve_info"."type" IS '漏洞类型';
COMMENT ON COLUMN "public"."basic_cve_info"."description" IS '漏洞详细描述';
COMMENT ON COLUMN "public"."basic_cve_info"."official_solutions" IS '官方解决方案';
COMMENT ON COLUMN "public"."basic_cve_info"."suggestions" IS '建议';
COMMENT ON COLUMN "public"."basic_cve_info"."references_list" IS '参考资料';
COMMENT ON COLUMN "public"."basic_cve_info"."cnvd_id" IS 'cnvd_id，暂时没有用到，也存下来';
COMMENT ON COLUMN "public"."basic_cve_info"."vector_string" IS '评分细则';
COMMENT ON COLUMN "public"."basic_cve_info"."exp_flag" IS '是否exp特征';
COMMENT ON COLUMN "public"."basic_cve_info"."public_time" IS '漏洞发布时间';
COMMENT ON COLUMN "public"."basic_cve_info"."update_time" IS '漏洞更新时间';
COMMENT ON COLUMN "public"."basic_cve_info"."affects" IS '受影响实体';


-- ----------------------------
-- Table structure for basic_setting_item
-- ----------------------------
DROP TABLE IF EXISTS "public"."basic_setting_item";
CREATE TABLE "public"."basic_setting_item" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" varchar(64) COLLATE "pg_catalog"."default",
  "type" varchar(64) COLLATE "pg_catalog"."default",
  "item" varchar(512) COLLATE "pg_catalog"."default",
  "expected" varchar(512) COLLATE "pg_catalog"."default",
  "description" varchar(512) COLLATE "pg_catalog"."default",
  "resource_class" varchar(255) COLLATE "pg_catalog"."default",
  "resource_param" varchar(255) COLLATE "pg_catalog"."default",
  "func_name" varchar(255) COLLATE "pg_catalog"."default",
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "sugguest" varchar(512) COLLATE "pg_catalog"."default",
  "level" varchar(255) COLLATE "pg_catalog"."default",
  "suggestion" varchar(255) COLLATE "pg_catalog"."default",
  "stig_id" varchar(128) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for docker_risk_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."docker_risk_records";
CREATE TABLE "public"."docker_risk_records" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip_address" varchar(32) COLLATE "pg_catalog"."default",
  "node_name" varchar(64) COLLATE "pg_catalog"."default",
  "item_id" varchar(64) COLLATE "pg_catalog"."default",
  "item" text COLLATE "pg_catalog"."default",
  "result" varchar(32) COLLATE "pg_catalog"."default",
  "suggestion" text COLLATE "pg_catalog"."default",
  "create_uid" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0)
)
;

-- ----------------------------
-- Table structure for setting_item_template
-- ----------------------------
DROP TABLE IF EXISTS "public"."setting_item_template";
CREATE TABLE "public"."setting_item_template" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(64) COLLATE "pg_catalog"."default",
  "item_type" varchar(64) COLLATE "pg_catalog"."default",
  "item_id" varchar(64) COLLATE "pg_catalog"."default",
  "item" varchar(255) COLLATE "pg_catalog"."default",
  "item_desc" varchar(512) COLLATE "pg_catalog"."default",
  "func_name" varchar(255) COLLATE "pg_catalog"."default",
  "create_uid" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "template_name" varchar(255) COLLATE "pg_catalog"."default",
  "description" varchar(512) COLLATE "pg_catalog"."default",
  "template_id" varchar(64) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for setting_risk_detect_items
-- ----------------------------
DROP TABLE IF EXISTS "public"."setting_risk_detect_items";
CREATE TABLE "public"."setting_risk_detect_items" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" varchar(64) COLLATE "pg_catalog"."default",
  "item" text COLLATE "pg_catalog"."default",
  "type" varchar(32) COLLATE "pg_catalog"."default",
  "type_id" int8,
  "level" varchar(32) COLLATE "pg_catalog"."default",
  "level_id" int8,
  "name" varchar(64) COLLATE "pg_catalog"."default",
  "distribution" text COLLATE "pg_catalog"."default",
  "system" text COLLATE "pg_catalog"."default",
  "system_ver" text COLLATE "pg_catalog"."default",
  "app_id" int8,
  "app" text COLLATE "pg_catalog"."default",
  "app_ver" text COLLATE "pg_catalog"."default",
  "suggestion" text COLLATE "pg_catalog"."default",
  "result" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for setting_risk_records_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."setting_risk_records_info";
CREATE TABLE "public"."setting_risk_records_info" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip_address" varchar(32) COLLATE "pg_catalog"."default",
  "type" varchar(32) COLLATE "pg_catalog"."default",
  "type_id" varchar(64) COLLATE "pg_catalog"."default",
  "level" varchar(32) COLLATE "pg_catalog"."default",
  "level_id" int8,
  "name" varchar(512) COLLATE "pg_catalog"."default",
  "item" text COLLATE "pg_catalog"."default",
  "item_id" varchar(64) COLLATE "pg_catalog"."default",
  "suggestion" text COLLATE "pg_catalog"."default",
  "result" varchar(32) COLLATE "pg_catalog"."default",
  "distribution" text COLLATE "pg_catalog"."default",
  "system" text COLLATE "pg_catalog"."default",
  "system_ver" text COLLATE "pg_catalog"."default",
  "app_id" int8,
  "app" text COLLATE "pg_catalog"."default",
  "app_ver" text COLLATE "pg_catalog"."default",
  "create_uid" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "agentid" varchar(128) COLLATE "pg_catalog"."default",
  "func_name" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."setting_risk_records_info"."id" IS '主键';
COMMENT ON COLUMN "public"."setting_risk_records_info"."node_ip_address" IS 'ip地址';
COMMENT ON COLUMN "public"."setting_risk_records_info"."type" IS '风险类型';
COMMENT ON COLUMN "public"."setting_risk_records_info"."type_id" IS '风险类型id';
COMMENT ON COLUMN "public"."setting_risk_records_info"."level" IS '风险等级';
COMMENT ON COLUMN "public"."setting_risk_records_info"."level_id" IS '风险等级id';
COMMENT ON COLUMN "public"."setting_risk_records_info"."name" IS '检测项概述';
COMMENT ON COLUMN "public"."setting_risk_records_info"."item" IS '检测项详述';
COMMENT ON COLUMN "public"."setting_risk_records_info"."item_id" IS '检测项id';
COMMENT ON COLUMN "public"."setting_risk_records_info"."result" IS '检测结果';

-- ----------------------------
-- Table structure for temp_basic_cve
-- ----------------------------
DROP TABLE IF EXISTS "public"."temp_basic_cve";
CREATE TABLE "public"."temp_basic_cve" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "affects" text COLLATE "pg_catalog"."default",
  "cnnvd_number" varchar(64) COLLATE "pg_catalog"."default",
  "cve_number" varchar(64) COLLATE "pg_catalog"."default",
  "level" varchar(64) COLLATE "pg_catalog"."default",
  "links" text COLLATE "pg_catalog"."default",
  "manufacturer" text COLLATE "pg_catalog"."default",
  "official_solutions" text COLLATE "pg_catalog"."default",
  "patch" text COLLATE "pg_catalog"."default",
  "public_time" varchar(255) COLLATE "pg_catalog"."default",
  "risk_type" varchar(255) COLLATE "pg_catalog"."default",
  "source" varchar(255) COLLATE "pg_catalog"."default",
  "summary" text COLLATE "pg_catalog"."default",
  "title" varchar(512) COLLATE "pg_catalog"."default",
  "type" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6)
)
;


-- ----------------------------
-- Table structure for weak_password_records_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."weak_password_records_info";
CREATE TABLE "public"."weak_password_records_info" (
  "id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip_address" varchar(32) COLLATE "pg_catalog"."default",
  "app" varchar(32) COLLATE "pg_catalog"."default",
  "app_id" int8,
  "weak_password_cnt" int8,
  "weak_password_detail" text COLLATE "pg_catalog"."default",
  "create_uid" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "agentid" varchar(128) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for win_vul_patch_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."win_vul_patch_info";
CREATE TABLE "public"."win_vul_patch_info" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_id" varchar(255) COLLATE "pg_catalog"."default",
  "check_status" int4 NOT NULL,
  "create_time" timestamp(6),
  "description" text COLLATE "pg_catalog"."default",
  "fix_end_time" timestamp(6),
  "fix_start_time" timestamp(6),
  "fix_status" int4 NOT NULL,
  "install_date" timestamp(6),
  "md5" varchar(255) COLLATE "pg_catalog"."default",
  "name" text COLLATE "pg_catalog"."default",
  "node_ip_address" varchar(255) COLLATE "pg_catalog"."default",
  "patch_id" varchar(255) COLLATE "pg_catalog"."default",
  "pubdate" timestamp(6),
  "result_code" int4 NOT NULL,
  "url" text COLLATE "pg_catalog"."default",
  "warn_level" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for k8s_risk_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."k8s_risk_records";
CREATE TABLE "public"."k8s_risk_records" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_id" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "create_uid" varchar(255) COLLATE "pg_catalog"."default",
  "item" varchar(255) COLLATE "pg_catalog"."default",
  "item_id" varchar(255) COLLATE "pg_catalog"."default",
  "node_ip_address" varchar(255) COLLATE "pg_catalog"."default",
  "node_name" varchar(255) COLLATE "pg_catalog"."default",
  "result" varchar(255) COLLATE "pg_catalog"."default",
  "suggestion" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for system_bug_records_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."system_bug_records_info";
CREATE TABLE "public"."system_bug_records_info" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "affect_scope" text COLLATE "pg_catalog"."default",
  "agent_id" varchar(255) COLLATE "pg_catalog"."default",
  "app" varchar(255) COLLATE "pg_catalog"."default",
  "app_id" int4,
  "app_ver" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6),
  "create_uid" varchar(255) COLLATE "pg_catalog"."default",
  "cve_number" varchar(255) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "distribution" varchar(255) COLLATE "pg_catalog"."default",
  "feature" text COLLATE "pg_catalog"."default",
  "feature_code" text COLLATE "pg_catalog"."default",
  "level" varchar(255) COLLATE "pg_catalog"."default",
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "node_ip_address" varchar(255) COLLATE "pg_catalog"."default",
  "score" varchar(255) COLLATE "pg_catalog"."default",
  "solution" text COLLATE "pg_catalog"."default",
  "suggestion" text COLLATE "pg_catalog"."default",
  "system" varchar(255) COLLATE "pg_catalog"."default",
  "system_ver" varchar(255) COLLATE "pg_catalog"."default",
  "type" varchar(255) COLLATE "pg_catalog"."default",
  "vector_string" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Primary Key structure for table system_bug_records_info
-- ----------------------------
ALTER TABLE "public"."system_bug_records_info" ADD CONSTRAINT "system_bug_records_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table k8s_risk_records
-- ----------------------------
ALTER TABLE "public"."k8s_risk_records" ADD CONSTRAINT "k8s_risk_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table win_vul_patch_info
-- ----------------------------
ALTER TABLE "public"."win_vul_patch_info" ADD CONSTRAINT "win_vul_patch_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table basic_cve_info
-- ----------------------------
CREATE INDEX "INDX_CVE_ID" ON "public"."basic_cve_info" USING btree (
  "cve_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table basic_cve_info
-- ----------------------------
ALTER TABLE "public"."basic_cve_info" ADD CONSTRAINT "basic_cve_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table basic_setting_item
-- ----------------------------
ALTER TABLE "public"."basic_setting_item" ADD CONSTRAINT "basic_setting_item_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table docker_risk_records
-- ----------------------------
ALTER TABLE "public"."docker_risk_records" ADD CONSTRAINT "docker_risk_records_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table setting_item_template
-- ----------------------------
ALTER TABLE "public"."setting_item_template" ADD CONSTRAINT "setting_item_template_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table setting_risk_detect_items
-- ----------------------------
ALTER TABLE "public"."setting_risk_detect_items" ADD CONSTRAINT "setting_risk_detect_items_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table setting_risk_records_info
-- ----------------------------
ALTER TABLE "public"."setting_risk_records_info" ADD CONSTRAINT "setting_risk_records_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table temp_basic_cve
-- ----------------------------
CREATE UNIQUE INDEX "INDX_CVE_NUMBER" ON "public"."temp_basic_cve" USING btree (
  "cve_number" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table temp_basic_cve
-- ----------------------------
ALTER TABLE "public"."temp_basic_cve" ADD CONSTRAINT "temp_basic_cve_pkey" PRIMARY KEY ("id");


-- ----------------------------
-- Primary Key structure for table weak_password_records_info
-- ----------------------------
ALTER TABLE "public"."weak_password_records_info" ADD CONSTRAINT "weak_password_records_info_pkey" PRIMARY KEY ("id");
