Class {
	#name : #MfMixingTableElement,
	#superclass : #ToElement,
	#classVars : [
		'keymap',
		'nbButtonPerRow',
		'nbButtons'
	],
	#category : #'Mooflod-MixingTableWidget'
}

{ #category : #adding }
MfMixingTableElement >> addButton: anElement key: aKey [
	"add the key passed as parameter to the key dictionnary"

	keymap at: aKey put: anElement.
	self addChild: anElement
	
]

{ #category : #initialization }
MfMixingTableElement >> defaultGeometry [
^ BlRectangleGeometry new
	
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> initEventListeners [
	"add the handler that changes color when pressing a key"

	self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key name
			ifPresent: [ :aButton | aButton background: Color red ] ].
			self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key name
			ifPresent: [ :aButton | aButton background: Color darkGray ] ].
	self requestFocus
]

{ #category : #accessing }
MfMixingTableElement >> initKeys [
	"create the keys that will be associated to buttons"

	| keys |
	keys := #( Q W E R T A S D F G ).
	keys do: [ :eachKey |
		self addButton: MfMixingButtonElement new key: eachKey ].
	self initEventListeners
]

{ #category : #initialization }
MfMixingTableElement >> initialize [

	super initialize.
	self geometry: self defaultGeometry.
	self size: self tableExtent.
	keymap := Dictionary new.
	self background: Color black.
	self border: (BlBorder paint: Color blue width: 2).
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]
]

{ #category : #accessing }
MfMixingTableElement >> keymap [


^keymap
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtonPerRow [

	^ nbButtonPerRow 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtonPerRow: rows [

	nbButtonPerRow  := rows.
	self layout columnCount: nbButtonPerRow 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtons [

^nbButtons 
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> nbButtons: buttons [

	nbButtons := buttons.
	self initKeys
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> openMixingTable: aTable [
"create a space to display the mixing table widget"
	| space |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aTable transformDo: [ :c | c translateBy: 180 @ 150 ].
	space root addChild: aTable.
	space toTheme: MfMixingTableTheme new.
	space applyAllSkinInstallers.
	space show.
	^ aTable
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> redefineKeys: keys [

	| v |
	v := keymap values.
	keymap := Dictionary new.
		keys withIndexDo: [ :key :index |
			| elem |
			elem := v at: index.
			keymap at: key put: elem ] .
	self initEventListeners
]

{ #category : #'as yet unclassified' }
MfMixingTableElement >> tableExtent [

	^ 400 @ 200
]
