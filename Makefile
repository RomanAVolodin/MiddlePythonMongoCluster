set_conf_servers:
	docker exec -it mongocfg1 bash -c 'echo "rs.initiate({_id: \"mongors1conf\", configsvr: true, members: [{_id: 0, host: \"mongocfg1\"}, {_id: 1, host: \"mongocfg2\"}, {_id: 2, host: \"mongocfg3\"}]})" | mongosh'

first_shard:
	docker exec -it mongors1n1 bash -c 'echo "rs.initiate({_id: \"mongors1\", members: [{_id: 0, host: \"mongors1n1\"}, {_id: 1, host: \"mongors1n2\"}, {_id: 2, host: \"mongors1n3\"}]})" | mongosh'

shard_to_router:
	docker exec -it mongos1 bash -c 'echo "sh.addShard(\"mongors1/mongors1n1\")" | mongosh'

second_shard:
	docker exec -it mongors2n1 bash -c 'echo "rs.initiate({_id: \"mongors2\", members: [{_id: 0, host: \"mongors2n1\"}, {_id: 1, host: \"mongors2n2\"}, {_id: 2, host: \"mongors2n3\"}]})" | mongosh'

add_second_to_cluster:
	docker exec -it mongos1 bash -c 'echo "sh.addShard(\"mongors2/mongors2n1\")" | mongosh'

create_db:
	docker exec -it mongors1n1 bash -c 'echo "use someDb" | mongosh'

turn_on_sharding:
	docker exec -it mongos1 bash -c 'echo "sh.enableSharding(\"someDb\")" | mongosh'

create_collection:
	docker exec -it mongos1 bash -c 'echo "db.createCollection(\"someDb.someCollection\")" | mongosh'

shard_by_field:
	docker exec -it mongos1 bash -c 'echo "sh.shardCollection(\"someDb.someCollection\", {\"someField\": \"hashed\"})" | mongosh'


all: set_conf_servers first_shard shard_to_router second_shard add_second_to_cluster create_db turn_on_sharding create_collection shard_by_field