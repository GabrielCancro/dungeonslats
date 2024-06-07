extends Node

var lang = "es"

var texts = {
	"ab_name_berserk_es": "Berserker es",
	"ab_desc_berserk_es": "Berserker: La furia se apodera de ti y haciendote capaz de vencer a quien sea que te enfrentes. Ganas +3@SW pero pierdes -1@HP",
	"slat_SW_es": "ESPADAS: Estos slats te permitirán superar desafios de combate y fuerza bruta",
	"slat_GR_es": "MECANISMOS: Estos slats te permitirán superar desafios mecanicos como cerraduras y trampas",
}

var images = {
	"@SW":"[img=15]res://assets/bbimg/bb_SW.png[/img]",
	"@HP":"[img=15]res://assets/bbimg/bb_hp.png[/img]"
}

func get_text(code):
	var lang_code = code+"_"+lang
	if !lang_code in texts: return "<"+lang_code+">"
	else: 
		var tx = texts[lang_code]
		if "@" in tx: 
			for k in images.keys(): tx = tx.replace(k,images[k])
			return "[center]"+tx+"[/center]"
		else: return tx
