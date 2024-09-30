#!/bin/nu

def run [
	package: string
	operations: string
] {
	let metadata: record = (^bash -c $"./buildtool/hook.sh ($package)") | from nuon

	^bash -c $"__BASED_BUILDTOOL__='($metadata | to nuon)' ./buildtool/hook.sh ($package) ($operations)"
}

# Build tool for Fruit Linux
def main [
	operation: string # Operation to run
	package: string   # Package to run the operation on
] {
	let operations = match $operation {
		fetch => {
			"pre_fetch do_fetch post_fetch"
		},
		extract => {
			"pre_extract do_extract post_extract"
		},
		configure => {
			"pre_configure do_configure post_configure"
		},
		build => {
			"pre_build do_build post_build"
		},
		install => {
			"pre_install do_install post_install"
		},
		package => {
			"pre_package do_package post_package"
		},
		run => {
			"pre_fetch do_fetch post_fetch pre_extract do_extract post_extract pre_configure do_configure post_configure pre_build do_build post_build"
		},
	}

	run $package $operations
}

