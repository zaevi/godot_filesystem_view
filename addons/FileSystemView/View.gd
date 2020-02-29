extends Reference

var name : String = ""
var icon : String = ""
var include: String = "" setget _set_include
var exclude: String = "" setget _set_exclude
var hide_empty_dirs: bool = true

var _includes = []
var _excludes = []

func _set_include(value):
	include = value
	_includes = _split_patterns(value)

func _set_exclude(value):
	exclude = value
	_excludes = _split_patterns(value)

func _split_patterns(pattern: String):
	if pattern == "":
		return []
	var patterns = pattern.split(";", false)
	return patterns

func _any_match(patterns: Array, path: String) -> bool:
	for pattern in patterns:
		if path.matchn(pattern):
			return true
	return false

func is_match(path: String) -> bool:
	if _includes.size() > 0 and not _any_match(_includes, path):
		return false
	if _excludes.size() > 0 and _any_match(_excludes, path):
		return false
	return true
