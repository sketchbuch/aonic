const creatorSortText = 'Dever, Joe';
const creatorText = 'Joe Dever';
const creatorType = 'author';
const creatorXml = '<creator class="$creatorType" sort-name="$creatorSortText">$creatorText</creator>';
const creatorJson = {
  "text": creatorText,
  "type": creatorType,
  "sortText": creatorSortText,
};

const descriptionType = 'publication';
const descriptionXml = '''<description class="$descriptionType">
  <p>You are Lone Wolf. In a devastating attack the Darklords have destroyed the monastery where you were learning the skills of the Kai Lords. You are the sole survivor.</p>
  <p>In <strong><cite>Flight from the Dark</cite></strong>, you swear revenge. But first you must reach Holmgard to warn the King of the gathering evil. Relentlessly the servants of darkness hunt you across your country and every turn of the page presents a new challenge. Choose your skills and your weapons carefully<ch.emdash/>for they can help you succeed in the most fantastic and terrifying journey of your life.</p>
</description>''';

const rightsXml = '''<rights class="licenseNotification">
  <p>
    <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
    <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
    <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
  </p>
</rights>''';
