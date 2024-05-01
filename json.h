#ifndef JSON_H
#define JSON_H

typedef struct  JsonObject      JsonObject;
typedef struct  JsonArray       JsonArray;
typedef struct  JsonNumber      JsonNumber;
typedef struct  JsonValue       JsonValue;

typedef struct  JsonKeyValue    JsonKeyValue;

typedef enum    JsonBool        JsonBool;
typedef enum    JsonValType     JsonValType;
typedef enum    JsonNumberType  JsonNumberType;

typedef union   JsonValueData   JsonValueData;
typedef union   JsonNumberData  JsonNumberData;

union JsonValueData {
    JsonObject* object;
    JsonArray*  array;
    JsonNumber* number;
    JsonBool*   bool;
    char*       str;
};

union JsonNumberData {
    int*        integer;
    float*      floatingPoint;
};

enum JsonValType { Object, Array, Number, Boolean, String };

enum JsonNumberType { Integer, FloatingPoint };

enum JsonBool { True, False };

struct JsonKeyValue {
    char* key;
    JsonValue* value;
};

struct JsonObject {
    JsonKeyValue* keyValues;
    int length;
};

struct JsonArray {
    JsonValue* array;
    int length;
};

struct JsonNumber {
    JsonNumberType type;
    JsonNumberData data;
};

struct JsonValue {
    JsonValueType type;
    JsonValueData data;
};

#endif
