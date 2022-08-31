part of 'translations.g.dart';

// Path: <root>
class _TranslationsDe implements _TranslationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsDe.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override final PluralResolver? _cardinalResolver; // ignore: unused_field
	@override final PluralResolver? _ordinalResolver; // ignore: unused_field

	@override late final _TranslationsDe _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
}

// Path: common
class _TranslationsCommonDe implements _TranslationsCommonEn {
	_TranslationsCommonDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String hello({required Object name}) => 'Hallo $name';
	@override String get save => 'Speichern';
	@override late final _TranslationsCommonLoginDe login = _TranslationsCommonLoginDe._(_root);
}

// Path: common.login
class _TranslationsCommonLoginDe implements _TranslationsCommonLoginEn {
	_TranslationsCommonLoginDe._(this._root);

	@override final _TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get success => 'Login erfolgreich';
	@override String get fail => 'Login fehlgeschlagen';
}
