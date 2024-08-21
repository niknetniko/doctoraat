# Doctoraatsproefschrift (_dissertation_)

De bronbestanden voor de tekst van mijn proefschrift.
De kern van de zaak speelt zich af in de map `src/`.

Bij een installatie van TeXLive kunt u `src/main.tex` compileren met `latexmk`, en er zal een proefschrift gemaakt worden (na wat tijd, 10 minuten is geen uitzondering).
Mensen die beschikken over Nix kunnen ook `nix build` uitvoeren in de repo.

Wat meer informatie:

- Startpunt is `src/main.tex`.
- Gebruikt KomaScript met LuaLatex, met Source Serif, Source Sans, en Source Code Pro.
- Alle grafieken en diagrammen zijn met TikZ/PGFPlots gemaakt (deels vandaar de lange compilatietijd).
- Alle andere afbeeldingen zijn waar mogelijk pdf.

Naast het hoofdcommando dat het proefschrift produceert (met `nix build`), kunnen enkele bijkomende documenten geproduceerd worden met:

- `nix build .#cover` voor de kaft
- `nix build .#invitation-nl` voor de Nederlandstalige uitnodiging
- `nix build .#invitation-en` voor de Engelstalige uitnodiging

Merk op dat de kaftillustratie onder licentie aan mij is; gebruik die niet zonder toestemming!
(Die zou strict genomen niet in de repository mogen zitten.)

----

The source files for the text of my dissertation.
The action is in the `src/` folder.

With an installation of TeXLive, you can compile `src/main.tex` with `latexmk` and the dissertation will appear (after some time, 6 minutes or more is not an exception).
People using Nix might also run `nix build` for the dissertation or other outputs for other documents.
