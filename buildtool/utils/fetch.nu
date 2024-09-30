use ../util.nu *

def fix-file-ext [from_suffixes: list<string>, to_suffix: string] -> string {
	let input: string = $in
	for suffix in $from_suffixes {
		if ($input | str ends-with $suffix) {
			return ($input | str replace $suffix $to_suffix)
		}
	}
	return $input
}

export def fix-file-exts [] -> string {
	$in
		| fix-file-ext ['tar.gz'] tgz
		| fix-file-ext ['tar.bz2'] tbz
		| fix-file-ext ['tar.xz', 'tar.lzma'] txz
		| fix-file-ext ['tar.zst'] tzst
}
	

export def fetch_distfile [distfile_url: string] {
	let fname = ($distfile_url | split row '/') | last

	let outpath = gen-distfile-path ($fname | fix-file-exts)

	^wget -O $"($outpath)" $distfile_url
}
