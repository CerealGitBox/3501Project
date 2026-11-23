function make_stamp(_id) {
	var _inst = instance_create_layer(_id.x + 700, _id.y + 571, "Instances", obj_stamp);
	_inst.parent_folder = _id;
}