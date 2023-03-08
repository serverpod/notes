--
-- Class Note as table note
--

CREATE TABLE "note" (
  "id" serial,
  "text" text NOT NULL
);

ALTER TABLE ONLY "note"
  ADD CONSTRAINT note_pkey PRIMARY KEY (id);


