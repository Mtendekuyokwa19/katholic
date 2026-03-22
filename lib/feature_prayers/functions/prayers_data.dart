import 'package:flutter/material.dart';
import '../models/prayer_model.dart';

class PrayersData {
  static const String _imgJesusOnCross = 'assets/images/jesus_on_cross.jpg';
  static const String _imgChurchOfEaster = 'assets/images/church_of_easr.jpg';
  static const String _imgCrossCrusader = 'assets/images/cross_crusader.jpg';
  static const String _imgKissingJesus = 'assets/images/kissing_jesus_feet.jpg';
  static const String _imgOldPaintings =
      'assets/images/old_paintings_of_jesus.jpg';
  static const String _imgPeopleChurch = 'assets/images/people_in_church.jpg';

  static final List<Prayer> featuredPrayers = [
    Prayer(
      id: 'hail_mary',
      title: 'Hail Mary',
      categories: ['basic'],
      icon: Icons.favorite,
      imageAsset: _imgKissingJesus,
      versions: [
        PrayerVersion(
          name: 'Traditional',
          content: '''Hail Mary, full of grace,
the Lord is with thee.
Blessed art thou amongst women,
and blessed is the fruit of thy womb, Jesus.

Holy Mary, Mother of God,
pray for us sinners,
now and at the hour of our death.

Amen.''',
        ),
        PrayerVersion(
          name: 'Modern',
          content: '''Hail Mary, full of grace, the Lord is with you.
Blessed are you among women,
and blessed is the fruit of your womb, Jesus.

Holy Mary, Mother of God, pray for us sinners,
now and at the hour of our death.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_michael',
      title: 'Prayer to St. Michael',
      categories: ['basic', 'saints'],
      icon: Icons.security,
      imageAsset: _imgCrossCrusader,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Holy Michael, the Archangel, defend us in battle.
Be our safeguard against the wickedness and snares of the devil.

May God rebuke him, we humbly pray; and do you,
O Prince of the heavenly host,
by the power of God cast into hell Satan and all the evil spirits
who wander through the world seeking the ruin of souls.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'our_father',
      title: 'Our Father',
      categories: ['basic'],
      icon: Icons.church,

      imageAsset: _imgChurchOfEaster,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Our Father, Who art in heaven,
Hallowed be Thy Name.
Thy Kingdom come.
Thy Will be done,
on earth as it is in Heaven.

Give us this day our daily bread.
And forgive us our trespasses,
as we forgive those who trespass against us.
And lead us not into temptation,
but deliver us from evil.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'guardian_angel',
      title: 'Guardian Angel',
      categories: ['basic', 'saints'],
      icon: Icons.nightlight_round,

      imageAsset: _imgPeopleChurch,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Angel of God,

my guardian dear,
to whom God's love
commits me here,
ever this day,
be at my side,
to light and guard,
rule and guide.

Amen.''',
        ),
      ],
    ),
  ];

  static final List<Prayer> allPrayers = [
    Prayer(
      id: 'hail_mary',
      title: 'Hail Mary',
      categories: ['basic'],
      icon: Icons.favorite,
      imageAsset: _imgKissingJesus,
      versions: [
        PrayerVersion(
          name: 'Traditional',
          content: '''Hail Mary, full of grace,
the Lord is with thee.
Blessed art thou amongst women,
and blessed is the fruit of thy womb, Jesus.

Holy Mary, Mother of God,
pray for us sinners,
now and at the hour of our death.

Amen.''',
        ),
        PrayerVersion(
          name: 'Modern',
          content: '''Hail Mary, full of grace, the Lord is with you.
Blessed are you among women,
and blessed is the fruit of your womb, Jesus.

Holy Mary, Mother of God, pray for us sinners,
now and at the hour of our death.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'our_father',
      title: 'Our Father',
      categories: ['basic'],
      icon: Icons.church,

      imageAsset: _imgChurchOfEaster,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Our Father, Who art in heaven,
Hallowed be Thy Name.
Thy Kingdom come.
Thy Will be done,
on earth as it is in Heaven.

Give us this day our daily bread.
And forgive us our trespasses,
as we forgive those who trespass against us.
And lead us not into temptation,
but deliver us from evil.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'glory_be',
      title: 'Glory Be',
      categories: ['basic'],
      icon: Icons.auto_awesome,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Glory be to the Father,
and to the Son,
and to the Holy Spirit,
as it was in the beginning,
is now, and ever shall be,
world without end.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'anima_christi',
      title: 'Anima Christi',
      categories: ['basic'],
      icon: Icons.local_fire_department,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Soul of Christ, sanctify me;
body of Christ, save me;
Blood of Christ, inebriate me;
Water from the side of Christ, wash me;
Passion of Christ, strengthen me;
O Good Jesus, hear me;
within Thy wounds hide me;
permit me not to be separated from You;
from the wicked foe, defend me;
at the hour of my death, call me;
and bid me come to You;
that with Your saints I may praise You
for ever and ever. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_michael',
      title: 'Prayer to St. Michael',
      categories: ['basic', 'saints'],
      icon: Icons.security,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Holy Michael, the Archangel, defend us in battle.
Be our safeguard against the wickedness and snares of the devil.

May God rebuke him, we humbly pray; and do you,
O Prince of the heavenly host,
by the power of God cast into hell Satan and all the evil spirits
who wander through the world seeking the ruin of souls.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'guardian_angel',
      title: 'Guardian Angel',
      categories: ['basic', 'saints'],
      icon: Icons.nightlight_round,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Angel of God,

my guardian dear,
to whom God's love
commits me here,
ever this day,
be at my side,
to light and guard,
rule and guide.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'memorare',
      title: 'Memorare',
      categories: ['basic'],
      icon: Icons.favorite_border,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Remember, O most gracious Virgin Mary,
that never was it known
that anyone who fled to thy protection,
implored thy help,
or sought thine intercession,
was ever left unaided.

Inspired by this confidence,
I fly unto thee,
O Virgin of virgins, my mother;
to thee do I come,
before thee I stand, sinful and sorrowful.
O Mother of the Word Incarnate,
despise not my petitions,
but in thy mercy hear and answer me. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'angelus',
      title: 'Angelus',
      categories: ['basic'],
      icon: Icons.notifications_active,
      versions: [
        PrayerVersion(
          name: '',
          content: '''℣. The Angel of the Lord declared to Mary:

℟. And she conceived of the Holy Spirit.

_Hail Mary..._

℣. Behold the handmaid of the Lord:

℟. Be it done unto me according to Thy word.

_Hail Mary..._

℣. And the Word was made Flesh:

℟. And dwelt among us.

_Hail Mary..._

℣. Pray for us, O Holy Mother of God,

℟. That we may be made worthy of the promises of Christ.

℣. Let us pray: Pour forth, we beseech Thee, O Lord, Thy grace into our hearts; that we, to whom the incarnation of Christ, Thy Son, was made known by the message of an angel, may by His Passion and Cross be brought to the glory of His Resurrection, through the same Christ Our Lord.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'regina_caeli',
      title: 'Regina Caeli',
      categories: ['basic'],
      icon: Icons.star,
      versions: [
        PrayerVersion(
          name: 'Queen of Heaven',
          content: '''℣. Queen of Heaven, rejoice, alleluia.

℟. For He whom you did merit to bear, alleluia.

℣. Has risen, as he said, alleluia.

℟. Pray for us to God, alleluia.

℣. Rejoice and be glad, O Virgin Mary, alleluia.

℟. For the Lord has truly risen, alleluia.

Let us pray.

O God, who gave joy to the world through the resurrection of Thy Son,
our Lord Jesus Christ, grant we beseech Thee,
that through the intercession of the Virgin Mary, His Mother,
we may obtain the joys of everlasting life.
Through the same Christ our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'prayer_before_meals',
      title: 'Prayer Before Meals',
      categories: ['basic', 'other'],
      icon: Icons.restaurant,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Bless us, O Lord,
and these Thy gifts
which we are about to receive
from Thy bounty,
through Christ, Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'fatima_prayer',
      title: 'Fatima Prayer',
      categories: ['basic'],
      icon: Icons.wb_sunny,
      versions: [
        PrayerVersion(
          name: '',
          content: '''O my Jesus,
forgive us our sins,
save us from the fires of hell,
and bring all souls to heaven,
especially those most in need of Thy mercy.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'eternal_rest',
      title: 'Eternal Rest',
      categories: ['basic'],
      icon: Icons.air,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Eternal rest grant unto them, O Lord,
and let perpetual light shine upon them.
May the souls of the faithful departed,
through the mercy of God, rest in peace.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'salve_regina',
      title: 'Salve Regina',
      categories: ['basic'],
      icon: Icons.waves,
      versions: [
        PrayerVersion(
          name: 'Hail Holy Queen',
          content: '''Hail, Holy Queen, Mother of Mercy,
our life, our sweetness and our hope.
To you do we cry, poor banished children of Eve;
to you do we send up our sighs,
mourning and weeping in this valley of tears.

Turn then, most gracious Advocate,
your eyes of mercy toward us,
and after this our exile,
show unto us the blessed fruit of your womb, Jesus.

O clement, O loving,
O sweet Virgin Mary.

ℛ. Pray for us, O Holy Mother of God,
that we may be made worthy of the promises of Christ.''',
        ),
      ],
    ),
    Prayer(
      id: 'we_fly_to_thy_protection',
      title: 'Sub Tuum Praesidium',
      categories: ['basic'],
      icon: Icons.shield,
      versions: [
        PrayerVersion(
          name: 'We Fly to Thy Protection',
          content: '''We fly to your protection,
O Holy Mother of God;
Despise not our petitions in our necessities,
but deliver us always from all dangers,
O glorious and blessed Virgin.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'apostles_creed',
      title: "Apostles' Creed",
      categories: ['creeds'],
      icon: Icons.article,
      versions: [
        PrayerVersion(
          name: '',
          content: '''I believe in God, the Father Almighty,
Creator of Heaven and earth;
and in Jesus Christ, His only Son Our Lord,
Who was conceived by the Holy Spirit,
born of the Virgin Mary,
suffered under Pontius Pilate,
was crucified, died, and was buried.

He descended into Hell;
the third day He rose again from the dead;
He ascended into Heaven,
and sitteth at the right hand of God,
the Father Almighty;
from thence He shall come
to judge the living and the dead.

I believe in the Holy Spirit,
the holy Catholic Church,
the communion of saints,
the forgiveness of sins,
the resurrection of the body
and life everlasting.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'nicene_creed',
      title: 'Nicene Creed',
      categories: ['creeds'],
      icon: Icons.menu_book,
      versions: [
        PrayerVersion(
          name: '',
          content: '''I believe in one God,
the Father almighty,
maker of heaven and earth,
of all things visible and invisible.

I believe in one Lord Jesus Christ,
the Only Begotten Son of God,
born of the Father before all ages.
God from God, Light from Light,
true God from true God,
begotten, not made, consubstantial with the Father;
through him all things were made.
For us men and for our salvation
he came down from heaven,

and by the Holy Spirit was incarnate
of the Virgin Mary,
and became man.

For our sake he was crucified
under Pontius Pilate,
he suffered death and was buried,
rose again on the third day
in accordance with the Scriptures.
He ascended into heaven
and is seated at the right hand of the Father.
He will come again in glory
to judge the living and the dead
and his kingdom will have no end.

I believe in the Holy Spirit, the Lord, the giver of life,
who proceeds from the Father and the Son,
who with the Father and the Son
is adored and glorified,
who has spoken through the prophets.

I believe in one, holy, catholic and apostolic Church.
I confess one Baptism for the forgiveness of sins
and I look forward to the resurrection of the dead
and the life of the world to come. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'athanasius_creed',
      title: 'Athanasian Creed',
      categories: ['creeds'],
      icon: Icons.history_edu,
      versions: [
        PrayerVersion(
          name: '',
          content:
              '''Whoever desires to be saved must, above all, hold the Catholic faith.
Unless everyone keeps it whole and undefiled,
without doubt he will perish forever.

Now the Catholic faith is this:
We worship one God in Trinity,
and Trinity in Unity,
neither confusing the persons
nor dividing the substance.

The Father is one person,
the Son is another,
the Holy Spirit is another;
but the Godhead of the Father, Son, and Holy Spirit
is one, the glory equal, the majesty co-eternal.

Thus the Father is God, the Son is God,
the Holy Spirit is God;
yet there are not three gods but one God.

Thus the Father is Lord, the Son is Lord,
the Holy Spirit is Lord;
yet there are not three lords but one Lord.

As we are compelled by Christian truth
to acknowledge each person by himself
to be both God and Lord,
so we are forbidden by the Catholic religion
to say there are three gods or three lords.

The Father is made by none,
not created, not begotten.
The Son is from the Father alone,
not made, not created, but begotten.
The Holy Spirit is from the Father and the Son,
not made, not created, but proceeding.

And yet there are not three unoriginated,
but one unoriginated;
but not three infinite,
but one infinite.

Similarly the Father is omnipotent,
the Son is omnipotent,
the Holy Spirit is omnipotent;
yet there are not three omnipotents,
but one omnipotent.

So the Father is God, the Son is God,
the Holy Spirit is God;
yet there are not three gods,
but one God.

So the Father is Lord, the Son is Lord,
the Holy Spirit is Lord;
yet there are not three lords,
but one Lord.

For as we are compelled by Christian truth
to acknowledge each person by himself
to be God and Lord,
so we are forbidden by the Catholic religion
to say there are three gods or three lords.

The Father is not made,
not created, not begotten.
The Son is from the Father only,
not made, not created, but begotten.
The Holy Spirit is from the Father and the Son,
not made, not created, but proceeding.

And in this Trinity no one is before or after,
greater or less than another;
but all three persons are co-eternal and co-equal.

So that throughout, as is previously stated,
both Unity in Trinity
and Trinity in Unity
may be worshipped.
Whoever wishes to be saved
must think thus of the Trinity.''',
        ),
      ],
    ),
    Prayer(
      id: 'joyful_mysteries',
      title: 'Joyful Mysteries',
      categories: ['rosary'],
      icon: Icons.celebration,

      imageAsset: _imgKissingJesus,
      versions: [
        PrayerVersion(
          name: 'Monday & Saturday',
          content: '''1. The Annunciation
_Fruit of the Mystery: Humility_

2. The Visitation
_Fruit of the Mystery: Love of Neighbour_

3. The Birth of Jesus
_Fruit of the Mystery: Poverty, Detachment from the things of the world, Contempt of Riches, Love of the Poor_

4. The Presentation of Jesus at the Temple
_Fruit of the Mystery: Gift of Wisdom and Purity of mind and body (Obedience)_

5. The Finding of Jesus in the Temple
_Fruit of the Mystery: True Conversion (Piety, Joy of Finding Jesus)_''',
        ),
      ],
    ),
    Prayer(
      id: 'sorrowful_mysteries',
      title: 'Sorrowful Mysteries',
      categories: ['rosary'],
      icon: Icons.sentiment_dissatisfied,

      imageAsset: _imgJesusOnCross,
      versions: [
        PrayerVersion(
          name: 'Tuesday & Friday',
          content: '''1. The Agony in the Garden
_Fruit of the Mystery: Sorrow for Sin, Uniformity with the Will of God_

2. The Scourging at the Pillar
_Fruit of the Mystery: Mortification (Purity)_

3. The Crowning with Thorns
_Fruit of the Mystery: Contempt of the World (Moral Courage)_

4. The Carrying of the Cross
_Fruit of the Mystery: Patience_

5. The Crucifixion and Death of our Lord
_Fruit of the Mystery: Perseverance in Faith, Grace for a Holy Death, Forgiveness_''',
        ),
      ],
    ),
    Prayer(
      id: 'glorious_mysteries',
      title: 'Glorious Mysteries',
      categories: ['rosary'],
      icon: Icons.auto_awesome,

      imageAsset: _imgOldPaintings,
      versions: [
        PrayerVersion(
          name: 'Wednesday & Sunday',
          content: '''1. The Resurrection
_Fruit of the Mystery: Faith_

2. The Ascension
_Fruit of the Mystery: Hope, Desire to Ascend to Heaven_

3. The Descent of the Holy Spirit
_Fruit of the Mystery: Love of God, Holy Wisdom to know the truth and share it with everyone, Divine Charity, Worship of the Holy Spirit_

4. The Assumption of Mary
_Fruit of the Mystery: Union with Mary and True Devotion to Mary_

5. The Coronation of the Virgin
_Fruit of the Mystery: Perseverance and an Increase in Virtue (Trust in Mary's Intercession)_''',
        ),
      ],
    ),
    Prayer(
      id: 'luminous_mysteries',
      title: 'Luminous Mysteries',
      categories: ['rosary'],
      icon: Icons.lightbulb,

      imageAsset: _imgOldPaintings,
      versions: [
        PrayerVersion(
          name: 'Thursday',
          content: '''1. The Baptism of Jesus in the Jordan
_Fruit of the Mystery: Openness to the Holy Spirit, the Healer_

2. The Wedding at Cana
_Fruit of the Mystery: To Jesus through Mary, Understanding of the ability to manifest through faith_

3. Jesus' Proclamation of the Kingdom of God
_Fruit of the Mystery: Trust in God (Call of Conversion to God)_

4. The Transfiguration
_Fruit of the Mystery: Desire for Holiness_

5. The Institution of the Eucharist
_Fruit of the Mystery: Adoration_''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_loreto',
      title: 'Litany of Loreto',
      categories: ['litany'],
      icon: Icons.format_list_numbered,

      imageAsset: _imgPeopleChurch,
      versions: [
        PrayerVersion(
          name: 'To the Holy Virgin Mary',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Holy Mary,
_Pray for us._

Holy Mother of God,
_Pray for us._

Holy Virgin of Virgins,
_Pray for us._

Mother of Christ,
_Pray for us._

Mother of the Church,
_Pray for us._

Mother of Mercy,
_Pray for us._

Mother of Divine Grace,
_Pray for us._

Mother of Hope,
_Pray for us._

Mother Most Pure,
_Pray for us._

Mother Most Chaste,
_Pray for us._

Mother Inviolate,
_Pray for us._

Mother Undefiled,
_Pray for us._

Mother Most Amiable,
_Pray for us._

Mother Most Admirable,
_Pray for us._

Mother of Good Counsel,
_Pray for us._

Mother of our Creator,
_Pray for us._

Mother of our Savior,
_Pray for us._

Virgin Most Prudent,
_Pray for us._

Virgin Most Venerable,
_Pray for us._

Virgin Most Renowned,
_Pray for us._

Virgin Most Powerful,
_Pray for us._

Virgin Most Merciful,
_Pray for us._

Virgin Most Faithful,
_Pray for us._

Mirror of Justice,
_Pray for us._

Seat of Wisdom,
_Pray for us._

Cause of Our Joy,
_Pray for us._

Spiritual Vessel,
_Pray for us._

Vessel of Honor,
_Pray for us._

Singular Vessel of Devotion,
_Pray for us._

Mystical Rose,
_Pray for us._

Tower of David,
_Pray for us._

Tower of Ivory,
_Pray for us._

House of Gold,
_Pray for us._

Ark of the Covenant,
_Pray for us._

Gate of Heaven,
_Pray for us._

Morning Star,
_Pray for us._

Health of the Sick,
_Pray for us._

Refuge of Sinners,
_Pray for us._

Solace of Migrants,
_Pray for us._

Comforter of the Afflicted,
_Pray for us._

Help of Christians,
_Pray for us._

Queen of Angels,
_Pray for us._

Queen of Patriarchs,
_Pray for us._

Queen of Prophets,
_Pray for us._

Queen of Apostles,
_Pray for us._

Queen of Martyrs,
_Pray for us._

Queen of Confessors,
_Pray for us._

Queen of Virgins,
_Pray for us._

Queen of All Saints,
_Pray for us._

Queen Conceived without Original Sin,
_Pray for us._

Queen Assumed into Heaven,
_Pray for us._

Queen of the Most Holy Rosary,
_Pray for us._

Queen of Families,
_Pray for us._

Queen of Peace,
_Pray for us._

Lamb of God, Who takest away the sins of the world,
_Spare us, O Lord._

Lamb of God, Who takest away the sins of the world,
_Graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_Have mercy on us._

℣. Pray for us, O holy Mother of God,

℟. That we be made worthy of the promises of Christ.

**Let us pray:**
Grant, we beseech thee,
O Lord God,
That we, your servants,
May enjoy perpetual health of mind and body;
And by the intercession of the Blessed Mary, ever Virgin,
May be delivered from present sorrow,
And obtain eternal joy.
Through Christ Our Lord.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_divine_mercy',
      title: 'Litany to the Divine Mercy',
      categories: ['litany'],
      icon: Icons.volunteer_activism,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Divine Mercy, greatest attribute of God,
_we trust in You._

Divine Mercy, unfathomable love of the Sanctifier,
_we trust in You._

Divine Mercy, incomprehensible mystery of the Most Blessed Trinity,
_we trust in You._

Divine Mercy, expression of the greatest might of God,
_we trust in You._

Divine Mercy, in creation of heavenly spirits,
_we trust in You._

Divine Mercy, in calling us forth from nothingness to existence,
_we trust in You._

Divine Mercy, encompassing the whole universe,
_we trust in You._

Divine Mercy, endowing us with immortal life,
_we trust in You._

Divine Mercy, shielding us from deserved punishment,
_we trust in You._

Divine Mercy, lifting us from the misery of sin,
_we trust in You._

Divine Mercy, justifying us through the Person of the Incarnate Word,
_we trust in You._

Divine Mercy, which flowed out from the wounds of Christ,
_we trust in You._

Divine Mercy, gushing forth from the Sacred Heart of Jesus,
_we trust in You._

Divine Mercy, giving us the Blessed Virgin Mary as Mother of Mercy,
_we trust in You._

Divine Mercy, in revealing the mysteries of God,
_we trust in You._

Divine Mercy, in the founding of the Holy Church,
_we trust in You._

Divine Mercy, in instituting the Holy Sacraments,
_we trust in You._

Divine Mercy, first of all in the sacraments of Baptism and Penance,
_we trust in You._

Divine Mercy, in the Holy Eucharist and the sacrament of Holy Orders,
_we trust in You._

Divine Mercy, in calling us to the holy faith,
_we trust in You._

Divine Mercy, in the conversion of sinners,
_we trust in You._

Divine Mercy, in sanctifying the just,
_we trust in You._

Divine Mercy, in perfecting of the pious,
_we trust in You._

Divine Mercy, fount of help for the sick and the suffering,
_we trust in You._

Divine Mercy, sweet relief for anguished hearts,
_we trust in You._

Divine Mercy, only hope of despairing souls,
_we trust in You._

Divine Mercy, accompanying us in every moment of our life,
_we trust in You._

Divine Mercy, anticipating our needs with graces,
_we trust in You._

Divine Mercy, repose of the dying,
_we trust in You._

Divine Mercy, heavenly delight of the saved,
_we trust in You._

Divine Mercy, respite and relief of the souls in Purgatory,
_we trust in You._

Divine Mercy, crown of All Saints,
_we trust in You._

Divine Mercy, inexhaustible source of miracles,
_we trust in You._

Lamb of God, who revealed the greatest mercy in redeeming the world by dying on the cross,
_spare us, O Lord._

Lamb of God, who mercifully offers Yourself for our sake in every holy Mass,
_graciously hear us, O Lord._

Lamb of God, who takes away our sins with inexhaustible compassion,
_have mercy on us._

℣. The Mercy of God is above all His works.

℟. Hence, we will praise The Divine Mercy forever and ever.

**Let us pray:**
Eternal God, in whom mercy is endless
and the treasury of compassion inexhaustible,
look kindly upon us and increase Your mercy in us,
that in difficult moments we might not despair
nor become despondent,
but with great confidence submit ourselves
to Your holy will, which is Love and Mercy itself.
Through our Lord Jesus Christ, King of mercy,
who with You and the Holy Spirit
shows us mercy now and forever.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_holy_spirit',
      title: 'Litany of the Holy Spirit',
      categories: ['litany'],
      icon: Icons.whatshot,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Spirit of the Father and the Son,
Life-giving Spirit of God,
_come to our aid._

Holy Spirit, Who proceedest from the Father and the Son,
_come to our aid._

Spirit of truth and love,
_come to our aid._

Spirit of wisdom and understanding,
_come to our aid._

Spirit of counsel and fortitude,
_come to our aid._

Spirit of knowledge and piety,
_come to our aid._

Spirit of the fear of the Lord,
_come to our aid._

Spirit of grace and prayer,
_come to our aid._

Spirit of adoption and sonship,
_come to our aid._

Spirit of peace and joy,
_come to our aid._

Spirit of patience and perseverance,
_come to our aid._

Spirit of temperance and self-control,
_come to our aid._

Spirit of humility and obedience,
_come to our aid._

Spirit of gentleness and goodness,
_come to our aid._

Spirit of mercy and compassion,
_come to our aid._

Lamb of God, Who takest away the sins of the world,
_Graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_Graciously hear us, O Christ._

Lamb of God, Who takest away the sins of the world,
_Have mercy on us._

℣. Send forth Your Spirit and they shall be created;

℟. And You shall renew the face of the earth.

**Let us pray:**
Come, Holy Spirit, fill the hearts of Your faithful,
and kindle in them the fire of Your love.

Send forth Your Spirit and they shall be created;
and You shall renew the face of the earth.

Let us pray:
O God, who taught the hearts of the faithful
by the light of the Holy Spirit,
grant that by the gift of the same Spirit
we may be always truly wise and ever rejoice in His consolation.
Through Christ our Lord.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_sacred_heart',
      title: 'Litany of the Sacred Heart',
      categories: ['litany'],
      icon: Icons.favorite,

      imageAsset: _imgJesusOnCross,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Heart of Jesus, Son of the Eternal Father,
_have mercy on us._

Heart of Jesus, formed by the Holy Spirit in the Virgin Mary's womb,
_have mercy on us._

Heart of Jesus, united with the Word of God,
_have mercy on us._

Heart of Jesus, of infinite majesty,
_have mercy on us._

Heart of Jesus, holy temple of God,
_have mercy on us._

Heart of Jesus, tabernacle of the Most High,
_have mercy on us._

Heart of Jesus, house of God and gate of heaven,
_have mercy on us._

Heart of Jesus, burning furnace of charity,
_have mercy on us._

Heart of Jesus, source of justice and love,
_have mercy on us._

Heart of Jesus, full of goodness and love,
_have mercy on us._

Heart of Jesus, abyss of all virtues,
_have mercy on us._

Heart of Jesus, most worthy of all praise,
_have mercy on us._

Heart of Jesus, king and center of all hearts,
_have mercy on us._

Heart of Jesus, in whom are hid all treasures of wisdom and knowledge,
_have mercy on us._

Heart of Jesus, whose property it is to have mercy,
_have mercy on us._

Heart of Jesus, for whom we desire all things,
_have mercy on us._

Heart of Jesus, source of all consolation,
_have mercy on us._

Heart of Jesus, our salvation and our refuge,
_have mercy on us._

Heart of Jesus, pledge of eternal life,
_have mercy on us._

Heart of Jesus, liberation and salvation of those who confess to You,
_have mercy on us._

Heart of Jesus, defender of those who cry out to You,
_have mercy on us._

Heart of Jesus,/delight of all the saints,
_have mercy on us._

Lamb of God, Who takest away the sins of the world,
_spare us, O Lord._

Lamb of God, Who takest away the sins of the world,
_graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_have mercy on us._

℣. Jesus, meek and humble of heart,

℟. Make our hearts like unto Yours.

**Let us pray:**
Almighty and eternal God,
look upon the Heart of Your beloved Son
and upon the praises and satisfaction
which He offers You in the name of sinners;
and do Thou, in Thy great goodness,
grant that they who implore Thy mercy
by reason of the Heart of Jesus,
may obtain Thy gracious pardon.
Who lives and reigns with You,
in the unity of the Holy Spirit,
world without end.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_st_joseph',
      title: 'Litany of St. Joseph',
      categories: ['litany', 'saints'],
      icon: Icons.handyman,

      imageAsset: _imgOldPaintings,
      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Holy Mary,
_Pray for us._

Holy Mother of God,
_Pray for us._

Holy Virgin of Virgins,
_Pray for us._

St. Joseph,
_Pray for us._

Renowned offspring of David,
_Pray for us._

Light of Patriarchs,
_Pray for us._

Spouse of the Mother of God,
_Pray for us._

Chaste guardian of the Virgin,
_Pray for us._

Foster father of the Son of God,
_Pray for us._

Diligent protector of Christ,
_Pray for us._

Head of the Holy Family,
_Pray for us._

Joseph, most just,
_Pray for us._

Joseph, most chaste,
_Pray for us._

Joseph, most prudent,
_Pray for us._

Joseph, most brave,
_Pray for us._

Joseph, most obedient,
_Pray for us._

Joseph, most faithful,
_Pray for us._

Mirror of patience,
_Pray for us._

Lover of poverty,
_Pray for us._

Model of artisans,
_Pray for us._

Glory of home life,
_Pray for us._

Guardian of virgins,
_Pray for us._

Breadwinner of families,
_Pray for us._

Solace of the wretched,
_Pray for us._

Hope of the sick,
_Pray for us._

Patron of the dying,
_Pray for us._

Terror of demons,
_Pray for us._

Protector of the Holy Church,
_Pray for us._

Lamb of God, Who takest away the sins of the world,
_spare us, O Lord._

Lamb of God, Who takest away the sins of the world,
_graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_have mercy on us._

℣. He made him master of His house,

℟. And ruler of all His possessions.

**Let us pray:**
O God, in Your ineffable providence
You were pleased to choose Joseph
as the spouse of the Virgin Mother of Your Son,
grant that we who revere him as our protector
may be worthy of his intercession.
Through the same Christ Our Lord.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_immaculate_heart',
      title: 'Litany of the Immaculate Heart',
      categories: ['litany'],
      icon: Icons.favorite_border,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Heart of Mary, Virgin Mother,
_hear us._

Heart of Mary, Mother of the Church,
_hear us._

Heart of Mary, Spouse of the Holy Spirit,
_hear us._

Heart of Mary, conceived without sin,
_hear us._

Heart of Mary, full of grace,
_hear us._

Heart of Mary, temple of the Holy Spirit,
_hear us._

Heart of Mary, sanctuary of the Trinity,
_hear us._

Heart of Mary, ark of the covenant,
_hear us._

Heart of Mary, house of the Lord,
_hear us._

Heart of Mary, most faithful,
_hear us._

Heart of Mary, most pure,
_hear us._

Heart of Mary, most humble,
_hear us._

Heart of Mary, most devoted,
_hear us._

Heart of Mary, most obedient,
_hear us._

Heart of Mary, most compassionate,
_hear us._

Heart of Mary, refuge of sinners,
_hear us._

Heart of Mary, comfort of the afflicted,
_hear us._

Heart of Mary, help of Christians,
_hear us._

Heart of Mary, queen of the sacred heart,
_hear us._

Lamb of God, Who takest away the sins of the world,
_spare us, O Lord._

Lamb of God, Who takest away the sins of the world,
_graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_have mercy on us._

℣. Pray for us, O holy Mother of God,

℟. That we may be made worthy of the promises of Christ.

**Let us pray:**
Lord Jesus Christ,
Savior of the human race,
the Immaculate Heart of Your Mother
was ever burning with love for You
and with the desire for the salvation of souls.
Pour forth, we beseech You,
the grace of conversion and sanctification
upon the whole world,
and enkindle in every heart
the fire of Your love.
Who lives and reigns with the Father
and the Holy Spirit, one God,
forever and ever.

℟. Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_after_communion',
      title: 'St. Thomas Aquinas: After Communion',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''I render thanks to You, O Lord, Holy Father,
Omnipotent and Eternal God,
who have vouchsafed to feed me,
a unworthy sinner,
with the precious Body and Blood
of Your Son, Our Lord Jesus Christ.

I return thanks to You,
and I declare that all my hope
and all my salvation
are fixed upon my Lord Jesus Christ,
who with You and the Holy Spirit
lives and reigns, God, forever and ever.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_grant_me_grace',
      title: 'St. Thomas Aquinas: Grant Me Grace',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Grant to me, O Lord my God,
that I may unswervingly follow
the path of Your truth,
without wavering or stumbling;
that I may progress in the knowledge of Yourself,
as a scholar of divine wisdom;
that my speech may be always seasoned with salt,
useful for the building up of faith,
and for the instruction and correction of souls.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_grant_to_me',
      title: 'St. Thomas Aquinas: Grant to Me',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Grant to me, O Lord,
to know what I ought to know;
to love what I ought to love;
to praise what delights You most;
to value what is precious in Your sight;
to hate what is evil before You;
to do what is profitable for me.

Give me the grace of Your protection,
and the medicine of my salvation.
Give me a guarded heart,
that no earthly thing may trouble me;
give me a right understanding,
that no false thing may deceive me;
give me sincerity of heart,
that no creature may make me sad;
give me constency of mind,
that no difficulty may cause me to flee;
give me the light of Your Holy Spirit,
that I may recognize Your will;
give me the fire of Your love,
that I may always serve You.

Through Christ Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_merciful_god',
      title: 'St. Thomas Aquinas: Merciful God',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Merciful God,
who didst enlighten the mind
of Your servant Thomas Aquinas
with the light of heavenly wisdom,
grant, we beseech You,
that we may understand what he taught,
and imitate what he accomplished.
Through Christ Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_prayer_good_life',
      title: 'St. Thomas Aquinas: For a Good Life',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Create in me a clean heart, O God,
and renew a right spirit within me.
Cast me not away from Your presence,
and take not Your Holy Spirit from me.
Restore unto me the joy of Your salvation,
and sustain me with a willing spirit.
Then will I teach transgressors Your ways,
and sinners shall be converted unto You.

O Lord, open my lips,
and my mouth shall show forth Your praise.
You desire not sacrifice; else would I give it;
You delight not in burnt offering.
The sacrifices of God are a broken spirit;
a broken and a contrite heart, O God,
You will not despise.

Glory be to the Father, and to the Son,
and to the Holy Spirit,
as it was in the beginning, is now,
and ever shall be, world without end.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_students_prayer',
      title: "St. Thomas Aquinas: Student's Prayer",
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Creator of all things,
true source of light and wisdom,
source and origin of all knowledge,
deign to direct and govern my studies
that I may come to the knowledge of myself
and of all truth.

Enlighten my understanding,
direct my memory,
guide my will,
that I may learn what You would have me learn.

Grant that I may approach the study of Your holy law
with a mind sober and disposed to receive Your truth,
and may faithfully fulfill Your will.

Give me a right judgment,
a sincere love of truth,
and a true Charity according to Your wisdom.

Help me to study
that I may labor at my tasks with humility,
that I may advance in virtue and goodness,
and that my study may bring forth good fruit.

Through Christ Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_students_prayer2',
      title: "St. Thomas Aquinas: Student's Prayer II",
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Almighty and eternal God,
look upon the Heart of Your servant
Saint Thomas Aquinas,
and honor the virtues
with which You did fill him.

We are certain that his learning
was not the reward of his studies,
but a gift poured upon him
from the treasury of Your goodness.

Grant, we pray,
that the gifts of Your grace
may so increase in us,
that growing in knowledge of Your truth,
we may come at last
to the perfect knowledge
of Yourself, who are the way, the truth, and the life.
Through Christ Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_thomas_aquinas_sweet_jesus',
      title: 'St. Thomas Aquinas: Sweet Jesus',
      categories: ['saints'],
      icon: Icons.school,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Sweet Jesus,
I render thanks to You
for the gift of faith,
for the gift of hope,
for the gift of love,
for the gift of life eternal.

May I keep these gifts faithfully.
May I grow in faith,
increase in hope,
and perfect my love,
that I may come at last
to the eternal vision of Your sweetness.
For You are sweet beyond all thought,
gentle beyond all words,
merciful beyond all measure,
and good beyond all understanding.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'st_pius_x_prayer_st_joseph_worker',
      title: 'St. Pius X: Prayer to St. Joseph Worker',
      categories: ['saints'],
      icon: Icons.construction,

      versions: [
        PrayerVersion(
          name: '',
          content: '''O Glorious St. Joseph,
model of all who are devoted to labor,
faithful fulfillment of daily duties,
preserve in us the spirit of prayer and humility,
and mercifully obtain for us
the grace to labor in the spirit of penance
for the atonement of our sins.

Obtain for us the grace
that our work may be well done,
finished placed in Your hands,
and rendered fruitful.

Grant that we may never tire in Your service,
nor lose heart in the face of difficulties.

May we, following Your example,
render to God what belongs to God,
and to Caesar what belongs to Caesar,
ever seeking first the Kingdom of God
and His justice.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'memorare_st_joseph',
      title: 'Memorare to St. Joseph',
      categories: ['saints'],
      icon: Icons.family_restroom,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Remember, O most chaste spouse of the Virgin Mary,
that never was it known
that anyone who fled to your protection,
implored your help,
or sought your intercession,
was ever left unaided.

Inspired with this confidence,
I fly unto you,
O foster-father of the Redeemer,
and as I earnestly invoke your divine patron,
I do also very earnestly present myself to you.

Despise not, O Guardian of the Holy Family,
my petition, but in your clemency
hear and answer my prayer.
Through Christ Our Lord.

Amen.''',
        ),
      ],
    ),
    Prayer(
      id: 'litany_saints',
      title: 'Litany of the Saints',
      categories: ['litany'],
      icon: Icons.groups,

      versions: [
        PrayerVersion(
          name: '',
          content: '''Lord, have mercy.
Christ, have mercy.
Lord, have mercy.

Christ, hear us.
Christ, graciously hear us.

God, the Father of Heaven,
_Have mercy on us._

God, the Son, Redeemer of the world,
_Have mercy on us._

God, the Holy Spirit,
_Have mercy on us._

Holy Trinity, One God,
_Have mercy on us._

Holy Mary,
_Pray for us._

Holy Mother of God,
_Pray for us._

Holy Virgin of Virgins,
_Pray for us._

St. Michael,
_Pray for us._

St. Gabriel,
_Pray for us._

St. Raphael,
_Pray for us._

All you Holy Angels,
_Pray for us._

St. John the Baptist,
_Pray for us._

St. Joseph,
_Pray for us._

All you Holy Patriarchs and Prophets,
_Pray for us._

St. Peter,
_Pray for us._

St. Paul,
_Pray for us._

St. Andrew,
_Pray for us._

St. John,
_Pray for us._

St. James,
_Pray for us._

St. Thomas,
_Pray for us._

All you Holy Apostles and Evangelists,
_Pray for us._

All you Holy Disciples of the Lord,
_Pray for us._

St. Stephen,
_Pray for us._

St. Lawrence,
_Pray for us._

All you Holy Martyrs,
_Pray for us._

St. Augustine,
_Pray for us._

St. Jerome,
_Pray for us._

St. Benedict,
_Pray for us._

St. Francis,
_Pray for us._

St. Dominic,
_Pray for us._

All you Holy Bishops and Confessors,
_Pray for us._

All you Holy Doctors,
_Pray for us._

St. Anthony,
_Pray for us._

St. Nicholas,
_Pray for us._

All you Holy Priests and Levites,
_Pray for us._

All you Holy Monks and Hermits,
_Pray for us._

St. Mary Magdalene,
_Pray for us._

St. Catherine,
_Pray for us._

St. Theresa,
_Pray for us._

All you Holy Virgins and Widows,
_Pray for us._

All you Holy Innocents,
_Pray for us._

Be merciful unto us,
_Deliver us, O Lord._

From all evil,
_Deliver us, O Lord._

From all sin,
_Deliver us, O Lord._

From the fury of the devil,
_Deliver us, O Lord._

From eternal death,
_Deliver us, O Lord._

By the mystery of Your Holy Incarnation,
_Deliver us, O Lord._

By Your Coming,
_Deliver us, O Lord._

By Your Birth,
_Deliver us, O Lord._

By Your Baptism and Holy Fasting,
_Deliver us, O Lord._

By Your Cross and Passion,
_Deliver us, O Lord._

By Your Death and Burial,
_Deliver us, O Lord._

By Your Holy Resurrection,
_Deliver us, O Lord._

By Your wonderful Ascension,
_Deliver us, O Lord._

By the coming of the Holy Spirit, the Comforter,
_Deliver us, O Lord._

In the day of judgment,
_Deliver us, O Lord._

We sinners,
_Beseech You, hear us._

That You would spare us,
_We beseech You, hear us._

That You would pardon us,
_We beseech You, hear us._

That You would bring us to true penance,
_We beseech You, hear us._

That You would instruct us,
_We beseech You, hear us._

That You would convert us to You,
_We beseech You, hear us._

That You would govern and preserve Your holy Church,
_We beseech You, hear us._

That You would preserve our Apostolic Prelate,
and all orders of the Church in holy religion,
_We beseech You, hear us._

That You would humble the enemies of holy Church,
_We beseech You, hear us._

That You would give peace and true concord
to Christian kings and princes,
_We beseech You, hear us._

That You would grant peace and unity to all Christian people,
_We beseech You, hear us._

That You would bring back to the unity of the Church
all who have strayed from the truth,
_We beseech You, hear us._

That You would confirm and keep us in Your holy service,
_We beseech You, hear us._

That You would lift our minds to heavenly desires,
_We beseech You, hear us._

That You would hear all our prayers,
_We beseech You, hear us._

That You would lead and protect our country
in true prosperity and Christian peace,
_We beseech You, hear us._

That You would grant eternal rest to all faithful souls,
_We beseech You, hear us._

Lamb of God, Who takest away the sins of the world,
_spare us, O Lord._

Lamb of God, Who takest away the sins of the world,
_graciously hear us, O Lord._

Lamb of God, Who takest away the sins of the world,
_have mercy on us._

Christ, hear us.
Christ, graciously hear us.

Lord, have mercy.
Christ, have mercy.
Lord, have mercy.''',
        ),
      ],
    ),
    Prayer(
      id: 'ten_commandments',
      title: 'Ten Commandments',
      categories: ['other'],
      icon: Icons.gavel,
      versions: [
        PrayerVersion(
          name: "God's Law",
          content: '''1. I am the LORD your God:
you shall not have strange gods before Me.

2. You shall not take the name of the LORD your God in vain.

3. Remember to keep holy the LORD's Day.

4. Honor your father and your mother.

5. You shall not kill.

6. You shall not commit adultery.

7. You shall not steal.

8. You shall not bear false witness against your neighbor.

9. You shall not covet your neighbor's wife.

10. You shall not covet anything that belongs to your neighbor.''',
        ),
      ],
    ),
  ];

  static List<PrayerCategory> getPrayersByCategory() {
    final Map<String, List<Prayer>> categoryMap = {};

    for (final prayer in allPrayers) {
      for (final category in prayer.categories) {
        if (!categoryMap.containsKey(category)) {
          categoryMap[category] = [];
        }
        categoryMap[category]!.add(prayer);
      }
    }

    return categoryMap.entries.map((entry) {
      return PrayerCategory(
        id: entry.key,
        name: Prayer.getCategoryDisplayName(entry.key),
        icon: Prayer.getCategoryIcon(entry.key),
        color: Prayer.getCategoryColor(entry.key),
        prayers: entry.value..sort((a, b) => a.title.compareTo(b.title)),
      );
    }).toList()..sort((a, b) {
      final order = ['basic', 'creeds', 'rosary', 'litany', 'saints', 'other'];
      return order.indexOf(a.id).compareTo(order.indexOf(b.id));
    });
  }

  static Prayer? getPrayerById(String id) {
    try {
      return allPrayers.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Prayer> searchPrayers(String query) {
    final lowerQuery = query.toLowerCase();
    return allPrayers
        .where(
          (p) =>
              p.title.toLowerCase().contains(lowerQuery) ||
              p.categories.any((c) => c.contains(lowerQuery)),
        )
        .toList();
  }
}
