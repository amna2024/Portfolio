

   ```{python}

import boto3

s3_client = boto3.client(service_name='s3')
translate = boto3.client('translate')

def translate_text(text, target_lang_code, source_lang_code='en'):  # Assuming English ('en') as the default source language
    result = translate.translate_text(
        Text=text,
        SourceLanguageCode=source_lang_code,
        TargetLanguageCode=target_lang_code
    )
    return result['TranslatedText']

def lambda_handler(event, context):
    file_name = event['Records'][0]['s3']['object']['key']
    bucketName = event['Records'][0]['s3']['bucket']['name']
    outfile = "s3://mytranslateaws/{}".format(file_name)
    print("Event details : ", event)
    print("Input File Name : ", file_name)
    print("Input Bucket Name : ", bucketName)
    print("Output File Name : ", outfile)

    result = s3_client.get_object(Bucket=bucketName, Key=file_name)

    final_document_array = ""
    for line in result["Body"].read().splitlines():
        each_line = line.decode('utf-8')
        print("Input Line : ", each_line)
        if each_line != '':
            translated = translate_text(each_line, 'sv')  
            print("After translation : ", translated)
            final_document_array += translated
            final_document_array += '\n\n'

    s3_client.put_object(Body=final_document_array, Bucket='mytranslateaws', Key=file_name)
    print("Done")

```
