import 'package:flutter/foundation.dart';
import 'package:orgro/src/data_source.dart';

/// 文档缓存，使用 LRU 策略
class DocumentCache {
  static final _cache = <String, ParsedOrgFileInfo>{};
  static final _accessOrder = <String>[];
  static const _maxCacheSize = 10;
  
  /// 获取或解析文档
  static Future<ParsedOrgFileInfo> getOrParse(DataSource source) async {
    final id = source.id;
    
    // 检查缓存
    if (_cache.containsKey(id)) {
      debugPrint('📦 Cache hit: $id');
      _updateAccessOrder(id);
      return _cache[id]!;
    }
    
    // 缓存未命中，解析文档
    debugPrint('💾 Cache miss: $id');
    final parsed = await ParsedOrgFileInfo.from(source);
    
    // 添加到缓存
    _addToCache(id, parsed);
    
    return parsed;
  }
  
  /// 添加到缓存
  static void _addToCache(String id, ParsedOrgFileInfo parsed) {
    // 如果缓存已满，移除最久未使用的项
    if (_cache.length >= _maxCacheSize) {
      final oldestKey = _accessOrder.first;
      _cache.remove(oldestKey);
      _accessOrder.removeAt(0);
      debugPrint('🗑️  Cache evicted: $oldestKey');
    }
    
    _cache[id] = parsed;
    _accessOrder.add(id);
    debugPrint('✅ Cache added: $id (size: ${_cache.length}/$_maxCacheSize)');
  }
  
  /// 更新访问顺序
  static void _updateAccessOrder(String id) {
    _accessOrder.remove(id);
    _accessOrder.add(id);
  }
  
  /// 清空缓存
  static void clear() {
    final size = _cache.length;
    _cache.clear();
    _accessOrder.clear();
    debugPrint('🧹 Cache cleared ($size items removed)');
  }
  
  /// 获取缓存统计
  static Map<String, dynamic> getStats() {
    return {
      'size': _cache.length,
      'maxSize': _maxCacheSize,
      'items': _cache.keys.toList(),
    };
  }
}

