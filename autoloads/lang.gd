extends Node

var lang = "es"

var texts = {
	"ab_name_berserk_es": "Berserker es",
	"ab_desc_berserk_es": "Berserker: La furia se apodera de ti y haciendote capaz de vencer a quien sea que te enfrentes. Ganas +3SW pero pierdes -1PV",
}

func get_text(code):
	var lang_code = code+"_"+lang
	if !lang_code in texts: return "<"+lang_code+">"
	else: return texts[lang_code]
