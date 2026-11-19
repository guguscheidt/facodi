-- facodi_credit_gustavo_scheidt_20261119, step 2 of 2. Run ONLY after the credit was approved in /editor/project-credits
-- (facodi.review_project_credit, audited). Sets what that form does not cover: the display name
-- the person asked for, the website link and the en/es/fr copy. Touches no consent or state field.
BEGIN;
WITH updated AS (
  UPDATE facodi.project_profiles
  SET display_name = 'Gustavo Scheidt',
      website_url = 'https://www.linkedin.com/in/gustavoscheidt',
      translations = '{"en": {"role_label": "Strategy, communications and growth", "headline": "Bringing FACODI to people who don''t know it exists yet.", "description": "Gustavo looks after FACODI''s strategy, outreach and communications: social media, partnerships and the path for the platform to reach more students."}, "es": {"role_label": "Estrategia, comunicación y crecimiento", "headline": "Llevar FACODI a quien todavía no sabe que existe.", "description": "Gustavo se ocupa de la estrategia, la captación y la comunicación de FACODI: redes sociales, alianzas y el camino para que la plataforma llegue a más estudiantes."}, "fr": {"role_label": "Stratégie, communication et croissance", "headline": "Faire connaître FACODI à celles et ceux qui ne la connaissent pas encore.", "description": "Gustavo s''occupe de la stratégie, de l''acquisition et de la communication de FACODI : réseaux sociaux, partenariats et le chemin pour que la plateforme atteigne davantage d''étudiants."}}'::jsonb,
      editorial_metadata = editorial_metadata || '{"copy_translated_on":"2026-11-19"}'::jsonb,
      updated_at = now()
  WHERE slug = 'gustavo-scheidt' AND entity_kind = 'person'
    AND publication_state = 'published' AND verification_state = 'verified_public'
    AND consent_for_public_credit
  RETURNING slug
)
SELECT count(*) AS profiles_updated FROM updated; -- 1 after approval, 0 before it
COMMIT;
