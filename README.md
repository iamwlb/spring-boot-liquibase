[toc]

## 1. 工程简介

基于 [liquibase](https://www.liquibase.com/) 跟踪、管理应用数据库变化的项目示例。

### 2.1. liquibase 简介

[Liquibase](https://www.liquibase.com/) 是一个用于跟踪、管理和应用数据库变化的开源的数据库重构工具。它将所有数据库的变化（包括结构和数据）都保存在XML文件中，便于版本控制。

### 1.2. 特性

#### 1.2.1. 数据库版本控制

将所有变化（包括结构和数据）存在 XML 文件中，便于版本控制的工具。liquibase 支持 XML、SQL、JSON、Yaml 4 种格式。
` 推荐使用 XML 格式 `

#### 1.2.2. 不依赖于特定数据库

Liquibase 会自动适配目标数据库进行脚本初始化，目前支持至少 30 种主流数据库。

#### 1.2.3. 数据库正向部署、升级

可以手动编写数据库变更文件，并将该文件自动生成数据库表、数据库记录。

#### 1.2.4. 逆向生成数据库变更文件

1.  可以将现有数据库自动逆向生成数据库变更文件
2.  可以将数据库与现有数据库变更文件比较，生成差异数据库变更文件

#### 1.2.5. 自动记录数据库修改历史

Liquibase 通过在数据库中保存数据库修改历史，在数据库升级时自动跳过已应用的变化（`changeSet`）

#### 1.2.6. 数据回滚

可以对数据库记录打标签，可按时间、数量或标签（tag）回滚已应用的变化。通过这种方式，开发人员可轻易的还原数据库在任何时间点的状态。

#### 1.2.7. 生成数据库修改文档

可以自动生成 HTML 格式数据库修改文档

## 2. 我们的软件产品当前面临哪些挑战？

### 2.1. 部署不够敏捷

我们的软件产品 acs 中有关系数据库，需要在开发环境、测试环境、uat 环境、客户环境中频繁部署，当开发人员、测试人员、运维人员需要部署、更新或是回滚数据库更改时，这会造成 ` 巨大的部署负担 `。
另外，更新数据库时的持续部署也比较难做。

### 2.2. 开发环节极易犯错

现在的开发人员是这么做的：

1.  将所有 sql 脚本统一存储在 Git 中的 [import-data](https://repo1.antiy.cn/acs-devops/import-data) 项目中
2.  需要部署时，由打包软件将该 import-data 拉取下来，在部署时通过脚本部署到目标服务器中。
3.  开发人员平时先进行功能开发、自测，开发完毕后，手工将数据库生成 sql 文件更新到 import-data 项目中。

由于某些原因，git 分支众多，这个过程极容易出错，譬如 sql 文件漏掉了某些部分，导致线上环境出问题。

### 2.3. 很难升级

比如，某客户部署了 1.0 版本的 acs 系统。
半年后，acs 系统已经开发到 1.3 版本，这时候很难给客户升级，只能是把 1.0 版本的系统删掉，重新安装 1.3 版本的系统。

## 3. 开发步骤

### 3.1. 添加 Maven 依赖

```xml:pom.xml  
<dependencies>  
   <!-- liquibase 依赖 -->   
   <dependency>       
        <groupId>org.liquibase</groupId>    
        <artifactId>liquibase-core</artifactId>    
   </dependency>  
</dependencies>
```  

### 3.2. 配置 application.yml

```yaml:application.yml  
spring:     
  datasource:    
    url: jdbc:postgresql://server-ip:5432/dbname    
    username: postgres    
    password: password    
    driverClassName: org.postgresql.Driver    
  liquibase:    
    # 指定配置文件路径    
    change-log: classpath:db/db.changelog-master.xml    
    # 如果为 true 相当于每次都重置数据库    
    drop-first: false    
    # 是否启用    
    enabled: true    
    # 记录版本日志表    
    database-change-log-table: databasechangelog    
    # 记录版本改变lock表    
    database-change-log-lock-table: databasechangeloglock
```  

### 3.3. 配置 db.changelog-master.xml

```xml:db.changelog-master.xml  
<?xml version="1.0" encoding="UTF-8"?>  <databaseChangeLog    
        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"    
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"    
        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog    
            http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd">    
    <include file="classpath:db/changelog/changelog-init-0.0.1.xml"/>  
</databaseChangeLog>  
```  

### 3.4. 配置 changelog-init-0.0.1.xml

```xml:changelog-init-0.0.1.xml  
<?xml version="1.1" encoding="UTF-8" standalone="no"?>  
<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog" xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext" xmlns:pro="http://www.liquibase.org/xml/ns/pro" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd http://www.liquibase.org/xml/ns/pro http://www.liquibase.org/xml/ns/pro/liquibase-pro-4.6.xsd http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.6.xsd">  
  
    <changeSet author="wanglibing" id="1662615627445-2">        
    <createTable tableName="role" remarks="角色信息表">    
            <column name="name" remarks="角色名称" type="VARCHAR(255)"/>    
            <column name="role_key" remarks="角色key" type="VARCHAR(255)"/>    
        </createTable>      
    </changeSet>  
    <changeSet author="wanglibing" id="1662615627445-3">        
    <createTable tableName="user" remarks="用户信息表">    
            <column name="id" type="INT" remarks="主键">    
                <constraints nullable="false" primaryKey="true"/>    
            </column>  
       <column name="username" type="VARCHAR(255)" remarks="用户名称"/>            
       <column name="password" type="VARCHAR(255)" remarks="密码"/>    
            <column name="age" type="INT" remarks="性别"/>    
            <column name="sex" type="VARCHAR(255)" remarks="性别"/>    
            <column name="role" type="VARCHAR(255)" remarks="角色"/>    
            <column name="create_time" type="DATETIME" defaultValueComputed="NOW()" remarks="创建时间"/>    
        </createTable>      
    </changeSet>  
</databaseChangeLog>  
```

### 3.5. 启动测试

项目启动后，查看数据库，可以看到 `changelog-init-0.0.1.xml` 文件中定义的脚本初始化到了数据库中。

### 3.6. 集成 Liquibase Maven Plaugin

使用 maven 集成 liquibase 可以方便的通过 liquibase maven plaugin 实现很多功能。例如：脚本运行，生成文档，数据库差异比较等

#### 3.6.1. 配置 pom.xml

```xml:pom.xml    
<build>    
    <plugins>          
        <!-- liquibase 插件，用于逆向生成xml、生成数据库修改文档、发布changelog、比较数据库差异 -->    
        <plugin>    
            <groupId>org.liquibase</groupId>    
            <artifactId>liquibase-maven-plugin</artifactId>    
            <configuration>      
                <propertyFileWillOverride>${basedir}/src/main/resources/db/liquibase.properties</propertyFileWillOverride>  
                <propertyFileWillOverride>true</propertyFileWillOverride>            
            </configuration>          
        </plugin>    
    
    </plugins>  
</build>  
```  

#### 3.6.2. 添加 liquibase.properties

```properties:liquibase.properties
# 数据库连接信息
driver=org.postgresql.Driver  
url=jdbc:postgresql://server-ip:5432/dbname
username=postgres  
password=password 

# liquibse系统表 表名称配置
databaseChangeLogTableName=databasechangelog  
databaseChangeLogLockTableName=databasechangeloglock

# 输出文件路径配置
outputChangeLogFile=src/main/resources/db/changelog/changelog-output-0.0.1.xml

# liuquibase xml文件路径指定
changeLogFile=src/main/resources/db/db.changelog-master.xml
```

## 4. 编写数据库变更文件（DDL）

### 4.1. 创建表

```xml
<changeSet author="ludangxin" id="20220908-1">
    <createTable tableName="order" remarks="订单信息表">
        <column name="id" remarks="主键" type="BIGINT">
            <constraints nullable="false" primaryKey="true"/>
        </column>
        <column name="order_number" remarks="订单编号" type="VARCHAR(255)"/>
        <column name="user_id" remarks="用户id" type="BIGINT"/>
    </createTable>
</changeSet>
```

### 4.2. 删除表

```xml
<changeSet author="ludangxin" id="20220908-2">
    <dropTable tableName="order"/>
</changeSet>
```

### 4.3. 修改表

#### 4.3.1. 添加字段

```xml
<changeSet author="ludangxin" id="20220908-3">
    <addColumn tableName="order">
        <column name="status" remarks="订单状态" type="INT" defaultValue="0"/>
    </addColumn>
</changeSet>
```

#### 4.3.2. 修改字段

```xml
<changeSet author="ludangxin" id="20220908-5">
    <renameColumn tableName="order" oldColumnName="status" newColumnName="state" columnDataType="VARCHAR(10)" remarks="订单状态"/>
</changeSet>
```

> [!WARNING]
> 修改字段类型 不建议使用 因为会把字段的其他信息搞丢，比如字段注释，如下所示

```xml
<changeSet author="ludangxin" id="20220908-7">
    <modifyDataType tableName="order" columnName="state" newDataType="INT" />
</changeSet>
```

#### 4.3.3. 删除字段

```xml
<changeSet author="ludangxin" id="20220908-4">
    <dropColumn tableName="order" columnName="order_number"/>
</changeSet>
```

## 5. 编写数据库变更文件（DML）

### 5.1. 从 Csv 文件导入数据

新建csv文件 `user-init-0.0.1.csv`
```csv:user-init-0.0.1.csv
"id","username","password","age","sex","role","create_time","create_by"
"111","张三","222","23","1","admin","2022-09-08 14:22:33","system"
"112","李四","333","26","1","admin","2022-09-08 14:22:33","system"
"113","王五","444","25","1","admin","2022-09-08 14:22:33","system"
```

使用`loadData`标签进行数据的初始化

```xml
<changeSet author="ludangxin" id="20220908-8">
    <loadData tableName="user" file="data/user-init-0.0.1.csv" 
              separator="," 
              encoding="UTF-8" 
              relativeToChangelogFile="true"/>
</changeSet>
```

### 5.2. 新增数据

```xml
<changeSet author="ludangxin" id="20220908-6">
    <insert tableName="order">
        <column name="id" valueNumeric="666"/>
        <column name="user_id" value="2222"/>
        <column name="state" value="2"/>
    </insert>
    <insert tableName="order">
        <column name="id" valueNumeric="888"/>
        <column name="user_id" value="3333"/>
        <column name="state" value="1"/>
    </insert>
</changeSet>
```

### 5.3. 初始化总是变动的数据

使用上述的 `loadData` 标签加载数据，当数据发生变化时，直接修改csv文件进行发布时，会报错版本不一致。

这时可以使用 `loadUpdateData` 标签进行处理，注意的是 `changeset`上需要加参数 `runOnChange="true"` (当数据发生改变时不去校验md5)如下

```xml
<changeSet author="ludangxin" id="20220908-9" runOnChange="true">
    <loadUpdateData tableName="user" file="data/user-init-0.0.1.csv"
              primaryKey="id"
              separator=","
              encoding="UTF-8"
              relativeToChangelogFile="true"/>
</changeSet>
```

## 6. 插件

### 6.1. 发布 Changelog

之前我们对changelog的编辑都需要通过启动项目来运行changelog，有时候我们可能想不重启项目便能将修改发布运行到数据库中

```bash
# 将修改同步到数据库中
> mvn liquibase:update
```

### 6.2. 从已有的数据库逆向生成 Changelog

```bash
# 从已有的数据库逆向生成 changelog
> mvn liquibase:generateChangeLog

# 逆向生成 changelog时指定 author
> mvn liquibase:generateChangeLog -Duser.name=YOURUSERNAME
```

### 6.3. 比较数据库差异

在properties中加入参考的数据库 `refer` 配置信息用于差异比较的数据库，以此数据库为准，生成diff xml

```properties:liquibase.properties
# 数据库连接信息
referenceDriver=org.postgresql.Driver  
referenceUrl=jdbc:postgresql://server-ip:5432/refer
referenceUsername=postgres  
referencePassword=password 
# 生成的差异比较xml的输出路径 
diffChangeLogFile=src/main/resources/db/changelog/changelog-diff-0.0.1.xml
```

```bash
# 比较数据库差异，并生成差异文件
> mvn liquibase:diff
```

### 6.4. 回滚

#### 6.4.1. 根据标签回滚

```bash
# 1. 打标签
> mvn liquibase:tag -Dliquibase.tag=1.0

# 2. 更新数据库，步骤略

# 3. 回滚到 1.0
> mvn liquibase:rollback -Dliquibase.rollbackTag=1.0
```

#### 6.4.2. 按计数回滚

```bash
# 回滚最后 1 次执行的变更集
> mvn liquibase:rollback -Dliquibase.rollbackCount=1
# 回滚倒数第 5 次执行的变更集
> mvn liquibase:rollback -Dliquibase.rollbackCount=5
```

#### 6.4.3. 回滚到日期

```bash
# 在该日期之后执行的任何变更集都将回滚
> mvn liquibase:rollback "-Dliquibase.rollbackDate=Jun 03, 2017"
```

### 6.5. 多环境属性文件

通常我们的数据库都是与多个环境对应的，如`dev`  、`uat`  、`prod`  等。我们可以通过`maven` 的变量来指定环境：

```xml
<properties>
  <liquibase.env>dev</liquibase.env>
</properties>

<propertyFile>target/classes/liquibase/properties/liquibase.${liquibase.env}.properties</propertyFile>
```

默认值为`dev`，然后可以通过传参指定其它：

```bash
> mvn clean package liquibase:update -Dliquibase.env=uat
```

### 6.6. 生成数据库修改文档

```bash
# 生成数据库修改文档，默认会生成到 target 目录中
> mvn liquibase:dbDoc
```

## 7. 常见问题

### 7.1 Liquibase 如何判断 是同一 Changeset 的？

`author` 和 `id` 唯一标识一个变化（ChangSet）

### 7.2. 为什么选择 liquibase？

市面上的同类产品，还有 Flyway，通过对比，最终选择了 liquibase。

两者对比如下：

| 对比项 | Flyway | 说明 |
| ---- |----|-----|
| 是否开源 | ✅ | ✅ |
| 与Java集成 | ✅ | ✅ |
| shell支持 | ✅ | ✅ |
| 数据库变更机制 | 基于迁移的数据库交付 | 基于迁移的数据库交付 |
| 生成差异 | ❌ | ✅ |
| 回滚支持 | 免费版不支持，付费版支持 | 免费支持，实现较为容易 |
| 跨平台支持 | ❌ | ✅ |

除此之外，还综合评估了 liquibase 的引入给研发团队是否会给研发团队带来负担，门槛如何？
最后结论是门槛并不高，也不会带来负担。

### 7.3. 数据库中如何初始化数据？

| 数据量 | 导入速度 | 导入方式 |
| ---- |----|-----|
| 极少 | 极快 | 数据写入 changeSet 中 |
| 适中 | 适中 | 数据存到 csv 中，在 changeSet 中通过 loadData 标签进行导入 |
| 极多 | 很慢 | 比如有些基础表，数据量有几百万，导入数据需要几个小时，这些基础数据不需要进行版本管理，长期不更新，可以通过将单条 sql 语句变成批量执行的方式，将导入速度从几小时优化至几分钟，这类数据初始化、更新通过 shell 脚本来做，优化后的sql文件由于无法增量更新，所以需要通过sql文件拆分来做增量更新。 |

### 7.4. 我们现有产品的数据库liquibase是否都已经支持?

| 数据库 | liquibase 默认支持 | liquibase 是否可以扩展支持 | 说明 |
| ---- |----|----| ----|
| Postgresql | ✅ | - |  |
| Clickhouse | ❌ | ✅ | 参考 [liquibase-clickhouse](https://github.com/MEDIARITHMICS/liquibase-clickhouse) <br>建议不要对clickhouse做版本管理，会让整个产品变得非常复杂，还需要做多源处理 |
| Neo4j | ✅ | - | 目前 neo4j 无需版本升级支持 |

### 7.5. 是否支持根据软件产品的版本来初始化不同数据？

> 场景：一款软件有全功能版、主机保护版、微隔离版三个版本，数据库中有一张菜单表，需要根据不同版本进行不同数据的初始化，以显示不同的用户菜单，这种情况该如何做？

默认情况下，liquibase 不支持这种场景。但是可以通过变通的方式解决这个问题。

| 方案名称 | 推荐做法 | 说明 |
| ---- |----|-----|
| 应用程序上做 | <font color="green">推荐</font><br>这种做法非常的灵活，如果用户有 lincense 升级的情况，不需要重新部署，用户可以自主升级，没有任何实施难度 | 1. 数据库里首先会初始化一个最小可用化版本的数据。<br>2. 用户会在管理后台上传一个 license 文件<br>3. 程序会根据 license 文件的版本，追加或者重新初始化数据。 |
| 部署程序上做 | <font color="red">不推荐</font><br>这种方式不够灵活，用户后期如果想变更版本，会有一定的实施难度跟实施成本 | 部署前需要跟用户协商好软件的版本，通过部署脚本进行部署、初始化 |

## 8. 参考

- [官网](https://www.liquibase.org/)
- [Github](https://github.com/liquibase/liquibase)
- [Docs](https://docs.liquibase.com/home.html?__hstc=128893969.d72a79464e67ef09bdc8bcac64ed4381.1665196981260.1665196981260.1665196981260.1&__hssc=128893969.1.1665196981261&__hsfp=4082224470&_ga=2.113031876.1330599802.1665196973-2027243285.1665196973)
- [Quickstart](https://docs.liquibase.com/start/home.html?__hstc=128893969.d72a79464e67ef09bdc8bcac64ed4381.1665196981260.1665196981260.1665196981260.1&__hssc=128893969.1.1665196981261&__hsfp=4082224470&_ga=2.87538136.1330599802.1665196973-2027243285.1665196973)
- [Tutorials](https://docs.liquibase.com/install/tutorials/home.html)