
  SELECT
    season_year,
    teamName,
    sum(freeThrowsAttempted-freeThrowsAttemptedOpponent) AS NetDifferenceFreeThrows
  FROM (
    SELECT
      a.season_year,
      a.gameId,
      a.matchup,
      a.teamName,
      SUM(a.freeThrowsAttempted) AS freeThrowsAttempted,
      SUM(b.freeThrowsAttempted) AS freeThrowsAttemptedOpponent
    FROM (
      SELECT
        a.season_year,
        a.gameId,
        a.matchup,
        a.teamName,
        SUM(a.freeThrowsAttempted) AS freeThrowsAttempted
      FROM `NBA.regular_season_box_scores_2010_2024_view` a
      GROUP BY ALL) a
    LEFT JOIN (
      SELECT
        gameId,
        matchup,
        teamName,
        SUM(freeThrowsAttempted) AS freeThrowsAttempted
      FROM `NBA.regular_season_box_scores_2010_2024_view`
      GROUP BY ALL) b ON a.gameId=b.gameId AND a.matchup<>b.matchup
    GROUP BY ALL )
  GROUP BY ALL