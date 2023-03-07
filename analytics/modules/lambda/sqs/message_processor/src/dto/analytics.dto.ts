import * as jf from 'joiful';

export class AnalyticsDto {
  @jf.string().isoDate().required()
  timestamp!: string;

  @jf.object().required()
  headers!: Record<string, any>;

  @jf.object().required()
  attributes!: Record<string, any>;
}

export class AnalyticsDocument extends AnalyticsDto {
  createdAt: Date = new Date();
}
