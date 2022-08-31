part of 'translations.g.dart';

// Path: <root>
class _TranslationsEn implements BaseTranslations {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	final PluralResolver? _cardinalResolver; // ignore: unused_field
	final PluralResolver? _ordinalResolver; // ignore: unused_field

	late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsCommonEn common = _TranslationsCommonEn._(_root);
}

// Path: common
class _TranslationsCommonEn {
	_TranslationsCommonEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String hello({required Object name}) => 'Hello $name';
	String get save => 'Save';
	late final _TranslationsCommonLoginEn login = _TranslationsCommonLoginEn._(_root);
}

// Path: common.login
class _TranslationsCommonLoginEn {
	_TranslationsCommonLoginEn._(this._root);

	final _TranslationsEn _root; // ignore: unused_field

	// Translations
	String get success => 'Logged in successfully';
	String get fail => 'Logged in failed';
}
