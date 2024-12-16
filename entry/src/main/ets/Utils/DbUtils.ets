import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';
import Logger from '../Logger/Logger'
import { ColumnInfo } from '../model/columnInfo';

const DB_FILENAME: string = 'WorkoutLogbook.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore;

  //initialize database
  initDB(context: common.UIAbilityContext): Promise<void> {
    //
    let config: relationalStore.StoreConfig = {
      name: DB_FILENAME,
      //Security level
      //S1 is the lowest level
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve, reject) => {
      //resolve return data after initialize
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => { //make async operation
          this.rdbStore = rdbStore
          console.info('rbdStore initial finish')
          resolve()
        })
        .catch((err: BusinessError) => {
          console.error(`rdbStore initialize fail, reason:${JSON.stringify(err)}`)
          reject(err)
        })
      //reject returned when initialization failed
    })
  }

  //Create database table
  createTable(createSQL: string): Promise<void>{
    return new Promise<void>((resolve, reject)=>{
      this.rdbStore.executeSql(createSQL)
        .then(()=>{
          Logger.debug('Success create table', createSQL)
          resolve()
        })
        .catch((err: BusinessError)=>{
          Logger.error('Create table failed!' + err.message, JSON.stringify(err) )
          reject(err)
        })
    })
  }

  //Insert data into table
  //todo: incompatible issues to be fixed
  // insert(tableName: string, obj: Object, columns:ColumnInfo[]):Promise<void>{
  //   return new Promise((resolve, reject)=>{
  //     //Construct new added data
  //     // let value =
  //   })
  // }
  //
  // // Convert datatype in table's column
  // buildValueBucket(obj: Object, columns: ColumnInfo[]):relationalStore.ValuesBucket{
  //   let value = {}
  //   columns.forEach(info=>{
  //     let val = obj[info.name]
  //     if(typeof val !== 'undefined'){
  //       value[info.columnName] = val
  //     }
  //   })
  //   return value
  // }
}

let dbUtil: DbUtil = new DbUtil()
export default dbUtil as DbUtil