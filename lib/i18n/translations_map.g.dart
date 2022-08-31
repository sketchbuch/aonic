part of 'translations.g.dart';

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _TranslationsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'common.hello': ({required Object name}) => 'Hello $name',
			'common.save': 'Save',
			'common.login.success': 'Logged in successfully',
			'common.login.fail': 'Logged in failed',
		};
	}
}

extension on _TranslationsDe {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'common.hello': ({required Object name}) => 'Hallo $name',
			'common.save': 'Speichern',
			'common.login.success': 'Login erfolgreich',
			'common.login.fail': 'Login fehlgeschlagen',
		};
	}
}
