import preferences from '@ohos.data.preferences';
import Logger from '../Logger/Logger'

// first preference tool
class PreferenceUtil {
  private pref!: preferences.Preferences

  //Load first preference
  async loadPreference(context: Context) {
    try {
      this.pref = await preferences.getPreferences(context, 'WorkoutLogbook')
      Logger.debug(`Load prefereces[WorkoutLogbook] success`)
    } catch (e) {
      Logger.debug(`Load preferences[WorkoutLogbook] fail`, JSON.stringify(e))
    }
  }

  //write down preference value
  async putPreferenceValue(key: string, value: preferences.ValueType){
    if(!this.pref){
      Logger.debug(`Preferences[WorkoutLogbook] not initialized!`)
      return
    }
    try{
      // write data
      await this.pref.put(key, value)
      // flush disk
      await this.pref.flush()
      Logger.debug(`Save Preferences[${key} = ${value}] success`)
    }
    catch (e){
      Logger.debug(`Save Preferences[${key} = ${value}] fails`, JSON.stringify(e))
    }
  }

  //get preference value
  async getPreferenceValue(key: string, defaultValue: preferences.ValueType){
    if(!this.pref){
      Logger.debug(`Preferences[WorkoutLogbook] not initialized!`)
      return
    }
    try{
      // read data
      let value = await this.pref.get(key, defaultValue)
      Logger.debug(`Read Preferences[${key} = ${value}] success`)
    }catch(e){
      Logger.debug(`Read Preferences[${key}] fails`, JSON.stringify(e))
    }
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil