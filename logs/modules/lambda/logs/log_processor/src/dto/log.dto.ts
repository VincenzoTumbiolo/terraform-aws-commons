import * as jf from 'joiful';

export class LogDto {
  @jf.string().required()
  uuid!: string;
  @jf.string().required()
  ipAddress!: string;
  @jf.string().required()
  level!: string;
  @jf.string().required()
  action!: string;
  @jf.string().required()
  system!: string;
  @jf.object().required()
  description!: Record<string, any>;
  @jf.string().optional()
  error!: string;
  @jf.string().required()
  createdAt!: string;
}
